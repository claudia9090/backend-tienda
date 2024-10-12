import { pool } from "../db.js";

export const getProductos = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM productos where activo = 1");
    res.json(rows);
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const getProductosAdmin = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM productos");
    res.json(rows);
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const getProducto = async (req, res) => {
  try {
    const { id } = req.params;
    const [rows] = await pool.query("SELECT * FROM productos WHERE id = ?", [id]);

    if (rows.length <= 0) {
      return res.status(404).json({ message: "No se encuentra el producto" });
    }

    res.json({data: rows[0], message : 'OK'});
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const createProducto = async (req, res) => {
  try {
    let nombreImagen = req.file.filename;
    const { nombre, descripcion, precio, stock, idcategoria } = req.body;
    const [rows] = await pool.query(
      "INSERT INTO productos (nombre, descripcion, precio, stock, imagen, idcategoria) VALUES (?, ?, ?, ?, ?, ?)",
      [nombre.toUpperCase().trim(), descripcion.toUpperCase().trim(), precio, stock, nombreImagen, idcategoria]
    );
    res.status(201).json({ id: rows.insertId, message: 'OK' });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error: " });
  }
};

export const updateProducto = async (req, res) => {
  try {
    const { id, nombre, descripcion, precio, stock, activo, idcategoria } = req.body;

    const [result] = await pool.query(
      "UPDATE productos SET nombre = IFNULL(?, nombre), descripcion = IFNULL(?, descripcion), precio = IFNULL(?, precio), stock = IFNULL(?, stock),activo = IFNULL(?, activo), idcategoria = IFNULL(?, idcategoria), fecha_actualizacion = now() WHERE id = ?",
      [nombre?.toUpperCase().trim(), descripcion?.toUpperCase().trim(), precio, stock, activo, idcategoria, id]
    );

    if (result.affectedRows === 0)
      return res.status(404).json({ message: "Producto no encontrado" });

    const [rows] = await pool.query("SELECT * FROM productos WHERE id = ?", [
      id,
    ]);

    res.json({data:rows[0], message: 'OK'});
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const updateProductoImage = async (req, res) => {
  try {
    let nombreImagen = req.file.filename;
    const { id } = req.body;

    const [result] = await pool.query(
      "UPDATE productos SET imagen = IFNULL(?, imagen) WHERE id = ?",
      [nombreImagen, id]
    );

    if (result.affectedRows === 0)
      return res.status(404).json({ message: "Producto no encontrado" });

    const [rows] = await pool.query("SELECT * FROM productos WHERE id = ?", [
      id,
    ]);

    res.json({data:rows[0], message: 'OK'});
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const getProductosByCategoria = async (req, res) => {
  try {
    const { idCategoria, nombreRol } = req.query;
    if(nombreRol == 'ADMIN'){
      const [rows] = await pool.query(`SELECT * FROM productos where idcategoria = ${idCategoria}`);
      res.json(rows);
    }else{
      const [rows] = await pool.query(`SELECT * FROM productos where activo = 1 and idcategoria = ${idCategoria}`);
      res.json(rows);
    }
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const getProductosByBusqueda = async (req, res) => {
  try {
    const { busqueda, nombreRol } = req.query;
    if(nombreRol == 'ADMIN'){
      const [rows] = await pool.query(`SELECT * FROM productos where regexp_like(nombre, '${busqueda}')`);
      res.json(rows);
    }else{
      const [rows] = await pool.query(`SELECT * FROM productos where activo = 1 and regexp_like(nombre, '${busqueda}')`);
      res.json(rows);
    }
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};

export const getProductosByOrdenId = async (req, res) => {
  try {
    const { idorden } = req.query;
    let query = `SELECT
                  p.id,
                  p.nombre,
                  p.descripcion,
                  p.imagen
                FROM orden o
                inner join detalles_orden d on d.idorden = o.id
                inner join productos p on p.id = d.idproducto
                where o.id = ${idorden} order by p.id desc`;

    const [rows] = await pool.query(query);
    res.json(rows);
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};