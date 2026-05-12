SET search_path TO configuration, public;

CREATE TABLE IF NOT EXISTS legal_information (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID NOT NULL,
  legal_document_type VARCHAR(80) NOT NULL,
  legal_document_number VARCHAR(80) NOT NULL,
  description TEXT,
  issue_date DATE,
  expiration_date DATE,
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT fk_legal_information_company FOREIGN KEY (company_id) REFERENCES configuration.company(id)
);

