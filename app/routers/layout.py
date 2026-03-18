# app/routers/layout.py
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db import get_db
from app.models import CatBeneficiario

router = APIRouter(tags=["Layout API"])

@router.get("/api/beneficiario/{id}")
def obtener_beneficiario(id: int, db: Session = Depends(get_db)):
    beneficiario = db.query(CatBeneficiario).filter(
        CatBeneficiario.id_beneficiario == id,
        CatBeneficiario.activo == True
    ).first()
    if not beneficiario:
        return {"error": "No encontrado"}

    cuenta = beneficiario.cuentas[0] if beneficiario.cuentas else None
    return {
        "nombre": beneficiario.nombre,
        "rfc": beneficiario.rfc,
        "cuenta": cuenta.numero_cuenta if cuenta else None,
        "banco": cuenta.id_institucion if cuenta else None,
        "tipo": cuenta.tipo_cuenta if cuenta else None
    }
