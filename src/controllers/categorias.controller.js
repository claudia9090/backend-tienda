import { pool } from "../db.js";

export const getCategorias = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM categorias order by id asc");
    res.json({data:rows, message: 'OK'});
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const getCategoria = async (req, res) => {
  try {
    const { id } = req.body;
    const [rows] = await pool.query("SELECT * FROM categorias WHERE id = ?", [
      id,
    ]);

    if (rows.length <= 0) {
      return res.status(404).json({ message: "No se encuentra la Categoria" });
    }

    res.json({data:rows[0], message: 'OK'});

  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const createCategoria = async (req, res) => {
  try {
    const { nombre } = req.body;
    const [validacionNombre] = await pool.query(
      "SELECT * FROM categorias WHERE nombre = ?",
      [nombre?.toUpperCase().trim()]
    );

    if (validacionNombre.length > 0) {
      res.status(200).json({ message: "La categoria ya existe" });
      return;
    }

    const [rows] = await pool.query(
      "INSERT INTO categorias (nombre) VALUES (?)",
      [nombre.toUpperCase().trim()]
    );
    res.status(201).json({ id: rows.insertId, message: 'OK' });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const updateCategoria = async (req, res) => {
  try {
    const { id, nombre } = req.body;

    const [validacionNombre] = await pool.query(
      "SELECT * FROM categorias WHERE nombre = ? and id <> ?",
      [nombre?.toUpperCase().trim(), id]
    );

    if (validacionNombre.length > 0) {
      res.status(200).json({ message: "La categoria ya existe" });
      return;
    }

    const [result] = await pool.query(
      "UPDATE categorias SET nombre = ? WHERE id = ?",
      [nombre?.toUpperCase().trim(), id]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({ message: "Categoria no encontrada" });
    }

    const [rows] = await pool.query("SELECT * FROM categorias WHERE id = ?", [
      id,
    ]);

    res.json({data: rows[0], message: 'OK'});
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};
