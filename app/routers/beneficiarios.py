from tempfile import template
from fastapi import Body
from fastapi import APIRouter, Request, Depends, Form, HTTPException
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session
from app.db import get_db
from app.models import CatBeneficiario, CatCuentaBeneficiario, CatInstitucionBancaria
import re
from fastapi.templating import Jinja2Templates

router = APIRouter(tags=["Beneficiarios"])
templates = Jinja2Templates(directory="app/templates")


# =========================
# Listar beneficiarios activos
# =========================
@router.get("/")
def listar(request: Request, db: Session = Depends(get_db)):
    beneficiarios = (
        db.query(CatBeneficiario).filter(CatBeneficiario.activo == True).all()
    )
    return templates.TemplateResponse(
        "beneficiarios/list.html", {"request": request, "beneficiarios": beneficiarios}
    )


# =========================
# Formulario crear
# =========================
@router.get("/crear")
def crear_form(request: Request):
    return templates.TemplateResponse("beneficiarios/create.html", {"request": request})


# =========================
# Crear beneficiario + cuenta
# =========================
@router.post("/crear")
def crear(
    nombre: str = Form(...),
    rfc: str = Form(None),
    curp: str = Form(None),
    correo: str = Form(None),
    celular: str = Form(None),
    tipo_cuenta: str = Form(...),
    numero_cuenta: str = Form(...),
    db: Session = Depends(get_db),
):
    # Validación existente
    if (
        db.query(CatBeneficiario)
        .filter(
            CatBeneficiario.nombre == nombre,
            CatBeneficiario.rfc == rfc,
            CatBeneficiario.activo == True,
        )
        .first()
    ):
        raise HTTPException(
            status_code=400,
            detail="Ya existe un beneficiario activo con el mismo nombre y RFC",
        )

    # Validación celular
    if celular and not re.fullmatch(r"\d{10}", celular):
        raise HTTPException(status_code=400, detail="El celular debe tener 10 dígitos")

    # Crear beneficiario
    beneficiario = CatBeneficiario(
        nombre=nombre, rfc=rfc, curp=curp, correo=correo, celular=celular
    )
    db.add(beneficiario)
    db.flush()  # para obtener ID

    # Validar cuenta existente
    if (
        db.query(CatCuentaBeneficiario)
        .filter(
            CatCuentaBeneficiario.numero_cuenta == numero_cuenta,
            CatCuentaBeneficiario.activo == True,
        )
        .first()
    ):
        raise HTTPException(
            status_code=400, detail="La cuenta ya está registrada y activa"
        )

    # Obtener banco
    # banco = obtener_institucion_por_cuenta(db, numero_cuenta)
    # if not banco:
    #    raise HTTPException(status_code=400, detail="Banco no válido")

    cuenta = CatCuentaBeneficiario(
        id_beneficiario=beneficiario.id_beneficiario,
        # id_institucion=banco["id_institucion"],
        # tipo_cuenta=tipo_cuenta,
        numero_cuenta=numero_cuenta,
    )
    db.add(cuenta)
    db.commit()

    return RedirectResponse("/beneficiarios/", status_code=303)


# =========================
# Formulario editar
# =========================
@router.get("/editar/{id}")
def editar_form(id: int, request: Request, db: Session = Depends(get_db)):
    beneficiario = db.get(CatBeneficiario, id)
    if not beneficiario:
        raise HTTPException(status_code=404, detail="Beneficiario no encontrado")
    return templates.TemplateResponse(
        "beneficiarios/edit.html", {"request": request, "beneficiario": beneficiario}
    )


# =========================
# Editar beneficiario
# =========================
@router.post("/editar/{id}")
def editar(
    id: int,
    nombre: str = Form(...),
    rfc: str = Form(None),
    curp: str = Form(None),
    correo: str = Form(None),
    celular: str = Form(None),
    db: Session = Depends(get_db),
):
    beneficiario = db.get(CatBeneficiario, id)
    if not beneficiario:
        raise HTTPException(status_code=404, detail="Beneficiario no encontrado")

    beneficiario.nombre = nombre
    beneficiario.rfc = rfc
    beneficiario.curp = curp
    beneficiario.correo = correo
    beneficiario.celular = celular
    db.commit()
    return RedirectResponse("/beneficiarios/", status_code=303)


# =========================
# Eliminar beneficiario (soft delete)
# =========================
@router.get("/eliminar/{id}")
def eliminar(id: int, db: Session = Depends(get_db)):
    beneficiario = db.get(CatBeneficiario, id)
    if not beneficiario:
        raise HTTPException(status_code=404, detail="Beneficiario no encontrado")
    beneficiario.activo = False
    db.commit()
    return RedirectResponse("/beneficiarios/", status_code=303)


# =========================
# API para autocompletar banco por prefijo
# =========================
@router.get("/api/bancos/{prefijo}")
def api_banco(prefijo: str, db: Session = Depends(get_db)):
    banco = (
        db.query(CatInstitucionBancaria)
        .filter(
            CatInstitucionBancaria.clave_banxico == prefijo,
            CatInstitucionBancaria.activo == True,
        )
        .first()
    )
    return {"nombre": banco.nombre_institucion if banco else None}


@router.post("/api/crear")
def crear_api(data: dict = Body(...), db: Session = Depends(get_db)):

    # Validar duplicado
    if (
        db.query(CatCuentaBeneficiario)
        .filter(
            CatCuentaBeneficiario.numero_cuenta == data["numero_cuenta"],
            CatCuentaBeneficiario.activo == True,
        )
        .first()
    ):
        # raise HTTPException(status_code=400, detail="La cuenta ya existe")
        cuenta_existente = (
            db.query(CatCuentaBeneficiario)
            .filter(
                CatCuentaBeneficiario.numero_cuenta == data["numero_cuenta"],
                CatCuentaBeneficiario.activo == True,
            )
            .first()
        )

    # ✅ SI YA EXISTE → regresar sin error
    if cuenta_existente:
        return {
            "id": cuenta_existente.beneficiario.id_beneficiario,
            "beneficiario": cuenta_existente.beneficiario.nombre,
            "clabe": cuenta_existente.numero_cuenta,
            "clabe_o_tarjeta": cuenta_existente.numero_cuenta,
        }

    beneficiario = CatBeneficiario(
        nombre=data["nombre"]
        .upper()
        .strip()
        # rfc=data.get("rfc")
    )

    db.add(beneficiario)
    db.flush()

    cuenta = CatCuentaBeneficiario(
        id_beneficiario=beneficiario.id_beneficiario,
        numero_cuenta=data["numero_cuenta"],
    )

    db.add(cuenta)
    db.commit()

    return {
        "id": beneficiario.id_beneficiario,
        "beneficiario": beneficiario.nombre,
        "clabe": data["numero_cuenta"],
        "clabe_o_tarjeta": data["numero_cuenta"],
    }
