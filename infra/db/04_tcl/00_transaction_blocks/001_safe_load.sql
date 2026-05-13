BEGIN;

  -- Validación previa
  DO $$
    BEGIN
      -- Check integridad de datos
      PERFORM COUNT(*) FROM configuration.customer;
      -- Si algo falla, Exception → ROLLBACK
    END
  $$;

  -- Inserciones principales
  INSERT INTO ...

  -- Validación post-carga
  DO $$
    BEGIN
      -- Verificar integridad
    END
  $$;

COMMIT;  -- Solo si todo OK
-- Si error → ROLLBACK automático
