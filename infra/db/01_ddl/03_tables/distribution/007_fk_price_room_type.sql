ALTER TABLE configuration.price
  ADD CONSTRAINT fk_price_room_type
  FOREIGN KEY (room_type_id) REFERENCES distribution.room_type(id);
