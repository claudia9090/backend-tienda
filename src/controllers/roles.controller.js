import { pool } from "../db.js";

export const getRoles = async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM rol order by id asc");
    res.json({data:rows, message: 'OK'});
  } catch (error) {
    return res.status(500).json({ message: "Ocurrio un error" });
  }
};
