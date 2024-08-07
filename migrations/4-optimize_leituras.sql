CREATE INDEX idx_leituras_radarid ON leituras (radar_id);
CREATE INDEX idx_leituras_velocidadeaferida ON leituras (velocidade_aferida);
ANALYZE leituras;