SET search_path TO distribution, public;

CREATE TABLE IF NOT EXISTS room (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  branch_id UUID NOT NULL,
  room_type_id UUID NOT NULL,
  room_status_id UUID NOT NULL,
  number VARCHAR(20) NOT NULL,
  floor SMALLINT,
  capacity SMALLINT NOT NULL,
  description VARCHAR(255),
  created_by UUID,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_by UUID,
  updated_at TIMESTAMPTZ,
  deleted_by UUID,
  deleted_at TIMESTAMPTZ,
  status configuration.record_status NOT NULL DEFAULT 'ACTIVE',
  CONSTRAINT ck_room_capacity CHECK (capacity > 0),
  CONSTRAINT fk_room_branch FOREIGN KEY (branch_id) REFERENCES distribution.branch(id),
  CONSTRAINT fk_room_room_type FOREIGN KEY (room_type_id) REFERENCES distribution.room_type(id),
  CONSTRAINT fk_room_room_status FOREIGN KEY (room_status_id) REFERENCES distribution.room_status(id)
);

