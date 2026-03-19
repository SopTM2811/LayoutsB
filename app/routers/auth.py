from fastapi import APIRouter, Request, Form, Depends
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from itsdangerous import URLSafeTimedSerializer
from app.db import get_db
from app.models import Usuario
import os

router = APIRouter(tags=["Auth"])
templates = Jinja2Templates(directory="app/templates")

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
SECRET_KEY = os.getenv("SECRET_KEY", "clave-secreta-cambiar")
serializer = URLSafeTimedSerializer(SECRET_KEY)


def hashear_password(password):
    return pwd_context.hash(password)


def verificar_password(plain, hashed):
    return pwd_context.verify(plain, hashed)


def crear_token(username: str):
    return serializer.dumps(username, salt="session")


def verificar_token(token: str):
    try:
        return serializer.loads(token, salt="session", max_age=86400)
    except:
        return None


@router.get("/login", response_class=HTMLResponse)
def login_form(request: Request):
    token = request.cookies.get("session")
    if token and verificar_token(token):
        return RedirectResponse(url="/operaciones/", status_code=302)
    return templates.TemplateResponse("auth/login.html", {"request": request})


@router.post("/login")
def login(
    request: Request,
    username: str = Form(...),
    password: str = Form(...),
    db: Session = Depends(get_db),
):
    usuario = (
        db.query(Usuario)
        .filter(Usuario.username == username, Usuario.activo == True)
        .first()
    )

    if not usuario or not verificar_password(password, usuario.password_hash):
        return templates.TemplateResponse(
            "auth/login.html",
            {"request": request, "error": "Usuario o contraseña incorrectos"},
        )

    token = crear_token(usuario.username)
    response = RedirectResponse(url="/operaciones/", status_code=302)
    response.set_cookie(
        key="session", value=token, httponly=True, max_age=86400, samesite="lax"
    )
    return response


@router.get("/logout")
def logout():
    response = RedirectResponse(url="/auth/login", status_code=302)
    response.delete_cookie("session")
    return response
