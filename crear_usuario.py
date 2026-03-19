from app.db import SessionLocal, Base, engine
from app.models import Usuario
from passlib.context import CryptContext

# ✅ Crear tablas si no existen
Base.metadata.create_all(bind=engine)

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


def crear_usuario(username: str, nombre: str, password: str):
    db = SessionLocal()

    if db.query(Usuario).filter(Usuario.username == username).first():
        print(f"❌ El usuario '{username}' ya existe")
        db.close()
        return

    usuario = Usuario(
        username=username,
        nombre=nombre,
        password_hash=pwd_context.hash(password),
    )
    db.add(usuario)
    db.commit()
    print(f"✅ Usuario '{username}' creado correctamente")
    db.close()


crear_usuario("mbco2", "Layouts Inter", "62.Mb")
