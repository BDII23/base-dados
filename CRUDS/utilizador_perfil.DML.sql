CREATE OR REPLACE PROCEDURE sp_utilizador_perfil_create(
    IN p_perfil VARCHAR(100)
)
LANGUAGE SQL
AS $$
    INSERT INTO utilizador_perfil (perfil)
    VALUES (p_perfil);
$$;





CREATE OR REPLACE PROCEDURE sp_utilizador_perfil_update(
    IN p_id INT,
    IN p_perfil VARCHAR(100)
)
LANGUAGE SQL
AS $$
    UPDATE utilizador_perfil
    SET perfil = p_perfil
    WHERE id = p_id;
$$;





CREATE OR REPLACE PROCEDURE sp_utilizador_perfil_delete(
    IN p_id INT
)
LANGUAGE SQL
AS $$
    DELETE FROM utilizador_perfil
    WHERE id = p_id;
$$;







CREATE OR REPLACE VIEW vw_utilizador_perfil_read AS
SELECT *
FROM utilizador_perfil;





CREATE OR REPLACE PROCEDURE sp_utilizador_perfil_readOne(
    IN p_id INT
)
LANGUAGE SQL
AS $$
    SELECT *
    FROM utilizador_perfil
    WHERE id = p_id;
$$;




