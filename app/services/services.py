from sqlalchemy.orm import Session
from sqlalchemy import text

def obtener_institucion_por_cuenta(db: Session, numero_cuenta: str):

    if len(numero_cuenta) < 3:
        return None

    prefijo = numero_cuenta[:3]

    result = db.execute(
        text("""
            SELECT id_institucion, nombre_institucion
            FROM cat_institucion_bancaria
            WHERE clave_banxico = :prefijo
        """),
        {"prefijo": prefijo}
    ).fetchone()

    if not result:
        return None

    return {
        "id_institucion": result[0],
        "nombre": result[1]
    }
