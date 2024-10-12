import { Router } from "express";
import { getRoles } from "../controllers/roles.controller.js";

const router = Router();

// GET all Roles
router.post("/roles", getRoles);

export default router;
