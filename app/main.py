from fastapi import FastAPI, Request
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse
from app.routers import beneficiarios, layout, home, operaciones, auth
from app.routers.auth import verificar_token
from app.db import Base, engine

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Sistema de Layouts")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.middleware("http")
async def auth_middleware(request: Request, call_next):
    rutas_publicas = ["/auth/login", "/static"]
    if any(request.url.path.startswith(r) for r in rutas_publicas):
        return await call_next(request)

    token = request.cookies.get("session")
    if not token or not verificar_token(token):
        return RedirectResponse(url="/auth/login", status_code=302)

    return await call_next(request)


@app.get("/", include_in_schema=False)
def root():
    return RedirectResponse(url="/operaciones/")


app.include_router(auth.router, prefix="/auth")
app.include_router(home.router, prefix="/home")
app.include_router(beneficiarios.router, prefix="/beneficiarios")
app.include_router(layout.router, prefix="/layout")
app.include_router(operaciones.router, prefix="/operaciones")
app.mount("/static", StaticFiles(directory="static"), name="static")
