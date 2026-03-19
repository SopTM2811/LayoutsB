from sqlalchemy import Column, DateTime, Integer, String, Boolean, ForeignKey, TIMESTAMP
from sqlalchemy.orm import relationship, validates
from sqlalchemy.sql import func
from app.db import Base
from sqlalchemy import Enum
from datetime import datetime


# =========================
# Enums
# =========================
class TipoCuentaEnum(Enum):
    CLABE = "CLABE"
    CUENTA = "CUENTA"
    TARJETA = "TARJETA"
    TELEFONO = "TELEFONO"


# =========================
# Catálogos Base
# =========================
class CatInstitucionBancaria(Base):
    __tablename__ = "cat_institucion_bancaria"
    id_institucion = Column(Integer, primary_key=True)
    nombre_institucion = Column(String(50), nullable=False)
    clave_banxico = Column(String(3), nullable=False)
    clave_transfer = Column(String(10))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())


class CatPlazaBanxico(Base):
    __tablename__ = "cat_plaza_banxico"
    id_plaza = Column(Integer, primary_key=True)
    numero = Column(String(5), nullable=False)
    ciudad = Column(String(100))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())


class CatInstitucionSTP(Base):
    __tablename__ = "cat_institucion_stp"
    id_stp = Column(Integer, primary_key=True)
    prefijo_clabe = Column(String(3), nullable=False)
    institucion = Column(String(100), nullable=False)
    participante = Column(String(10), nullable=False)
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())


# =========================
# Origen Operativo y Opciones
# =========================
class CatOrigenOperativo(Base):
    __tablename__ = "cat_origen_operativo"
    id_origen = Column(Integer, primary_key=True)
    codigo = Column(String(30), nullable=False)
    descripcion = Column(String(150))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())

    opciones = relationship("CatOrigenOpcion", back_populates="origen")


class CatOrigenOpcion(Base):
    __tablename__ = "cat_origen_opcion"
    id_opcion = Column(Integer, primary_key=True)
    id_origen = Column(
        Integer, ForeignKey("cat_origen_operativo.id_origen"), nullable=False
    )
    codigo = Column(String(30), nullable=False)
    descripcion = Column(String(150))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())

    origen = relationship("CatOrigenOperativo", back_populates="opciones")


# =========================
# Layouts
# =========================
class CatLayout(Base):
    __tablename__ = "cat_layout"
    id_layout = Column(Integer, primary_key=True)
    codigo = Column(String(50), nullable=False)
    id_origen = Column(
        Integer, ForeignKey("cat_origen_operativo.id_origen"), nullable=False
    )
    id_opcion = Column(
        Integer, ForeignKey("cat_origen_opcion.id_opcion"), nullable=True
    )
    tipo_archivo = Column(String(10), nullable=False)
    separador = Column(String(5))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())
    tipo_layout = Column(String)
    ruta_plantilla = Column(String)

    campos = relationship(
        "CatLayoutCampo", back_populates="layout", cascade="all, delete-orphan"
    )


class CatLayoutCampo(Base):
    __tablename__ = "cat_layout_campo"
    id_layout_campo = Column(Integer, primary_key=True)
    id_layout = Column(Integer, ForeignKey("cat_layout.id_layout"), nullable=False)
    nombre_logico = Column(String(50), nullable=False)
    etiqueta_ui = Column(String(100), nullable=False)
    posicion_inicio = Column(Integer, nullable=False)
    longitud = Column(Integer)
    obligatorio = Column(Boolean, default=False)
    editable = Column(Boolean, default=True)
    valor_fijo = Column(String(100))
    formato = Column(String(50))
    padding = Column(String(10))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())
    tipo_campo = Column(String)
    hoja_excel = Column(String)
    celda_excel = Column(String)
    fila_inicio = Column(String)
    layout = relationship("CatLayout", back_populates="campos")
    validaciones = relationship(
        "CatLayoutCampoValidacion", back_populates="campo", cascade="all, delete-orphan"
    )


class CatLayoutCampoValidacion(Base):
    __tablename__ = "cat_layout_campo_validacion"
    id_validacion = Column(Integer, primary_key=True)
    id_layout_campo = Column(
        Integer, ForeignKey("cat_layout_campo.id_layout_campo"), nullable=False
    )
    tipo = Column(String(50), nullable=False)
    valor = Column(String(100))
    mensaje_error = Column(String(255))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())

    campo = relationship("CatLayoutCampo", back_populates="validaciones")


# =========================
# Beneficiarios y Cuentas
# =========================
class CatBeneficiario(Base):
    __tablename__ = "cat_beneficiario"
    id_beneficiario = Column(Integer, primary_key=True)
    nombre = Column(String(150), nullable=False)
    alias_nom = Column(String(150))
    rfc = Column(String(13))
    curp = Column(String(18))
    correo = Column(String(150))
    celular = Column(String(10))
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())

    cuentas = relationship(
        "CatCuentaBeneficiario",
        back_populates="beneficiario",
        cascade="all, delete-orphan",
    )


class CatCuentaBeneficiario(Base):
    __tablename__ = "cat_cuenta_beneficiario"
    id_cuenta_beneficiario = Column(Integer, primary_key=True)
    id_beneficiario = Column(
        Integer, ForeignKey("cat_beneficiario.id_beneficiario"), nullable=False
    )
    numero_cuenta = Column(String(18), nullable=False, unique=True)
    activo = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP, server_default=func.now())
    beneficiario = relationship("CatBeneficiario", back_populates="cuentas")


class Usuario(Base):
    __tablename__ = "usuarios"

    id_usuario = Column(Integer, primary_key=True, index=True)
    username = Column(String(50), unique=True, nullable=False)
    nombre = Column(String(100), nullable=False)
    password_hash = Column(String(255), nullable=False)
    activo = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)
