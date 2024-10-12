import { Router } from "express";
import {
  createCategoria,
  getCategorias,
  getCategoria,
  updateCategoria
} from "../controllers/categorias.controller.js";

const router = Router();

// GET all Categorias
router.post("/categorias", getCategorias);

// GET An Categoria
router.post("/categoria/", getCategoria);

// INSERT An Categoria
router.post("/categoria/create", createCategoria);

// UPDATE An Categoria
router.post("/categoria/update", updateCategoria);

export default router;
