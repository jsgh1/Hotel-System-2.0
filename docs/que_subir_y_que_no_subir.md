# Que se sube y que no se sube

Este documento evita subir archivos locales, temporales o sensibles.

## Si se sube

- `docs/`
- `infra/db/`
- `README.md` del repositorio si existe
- archivos de configuracion necesarios para ejecutar Docker y Liquibase

## No se sube

- credenciales reales en `.env`
- dumps, backups y exportaciones temporales
- carpetas de cache, logs locales y artefactos generados
- dependencias instaladas localmente
- archivos de IDE que no aportan a la entrega

## Regla simple

Si un archivo no ayuda a reproducir la entrega o a entenderla, no debe subir al repositorio.
