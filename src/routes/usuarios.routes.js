import { Router } from "express";
import {
  createUsuario,
  getUsuario,
  updateUsuario,
  loginUsuario,
  restablecerPassword,
  listaEmpleados,
  createEmpleado,
  getEmpleado,
  updateEmpleado,
  actualizarPassword
} from "../controllers/usuarios.controller.js";

const router = Router();

// INSERT An Usuario
router.post("/usuario/create", createUsuario);

// GET An Usuario
router.post("/usuario", getUsuario);

// UPDATE An Usuario
router.post("/usuario/update", updateUsuario);

// Login Usuario
router.post("/usuario/login", loginUsuario);

// Restablecer password Usuario
router.post("/usuario/restablecer/password", restablecerPassword);

// lista empleados
router.post("/usuario/listEmployees", listaEmpleados);

// INSERT An Usuario
router.post("/usuario/createEmployees", createEmpleado);

// GET An Empleado
router.post("/usuario/employee", getEmpleado);

// UPDATE An Empleado
router.post("/usuario/update/employee", updateEmpleado);

// UPDATE password user 
router.post("/usuario/update/password", actualizarPassword);

export default router;
