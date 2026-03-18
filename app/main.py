from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse
from app.routers import beneficiarios, layout, home, operaciones

app = FastAPI(title="Sistema de Layouts")

# Middleware CORS para fetch desde JS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Redirigir root al home
@app.get("/", include_in_schema=False)
def root():
    return RedirectResponse(url="/home/")

# Routers con prefijo
app.include_router(home.router, prefix="/home", tags=["Home"])
app.include_router(beneficiarios.router, prefix="/beneficiarios", tags=["Beneficiarios"])
app.include_router(layout.router, prefix="/layout", tags=["Layout API"])
app.include_router(operaciones.router, prefix="/operaciones", tags=["Operaciones"])  # <-- incluir router


# Archivos estáticos
app.mount("/static", StaticFiles(directory="static"), name="static")
