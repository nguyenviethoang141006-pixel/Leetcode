const express = require("express");
const cors = require("cors");
require("dotenv").config();

const { sql, poolPromise } = require("./db");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Test API
app.get("/", (req, res) => {
    res.status(200).json({
        message: "GPay backend API is running"
    });
});

// Get all products
app.get("/api/products", async (req, res) => {
    try {
        const pool = await poolPromise;

        const result = await pool
            .request()
            .query(`
                SELECT
                    ID,
                    Name,
                    ItemPrice
                FROM Product
            `);

        res.status(200).json(result.recordset);
    } catch (error) {
        console.error("Get products error:", error);

        res.status(500).json({
            message: "Could not retrieve products"
        });
    }
});

// Get one product by ID
app.get("/api/products/:id", async (req, res) => {
    try {
        const productID = Number(req.params.id);

        if (!Number.isInteger(productID) || productID <= 0) {
            return res.status(400).json({
                message: "Product ID must be a positive integer"
            });
        }

        const pool = await poolPromise;

        const result = await pool
            .request()
            .input("productID", sql.Int, productID)
            .query(`
                SELECT
                    ID,
                    Name,
                    ItemPrice
                FROM Product
                WHERE ID = @productID
            `);

        if (result.recordset.length === 0) {
            return res.status(404).json({
                message: "Product not found"
            });
        }

        res.status(200).json(result.recordset[0]);
    } catch (error) {
        console.error("Get product error:", error);

        res.status(500).json({
            message: "Could not retrieve the product"
        });
    }
});

// Create a product
app.post("/api/products", async (req, res) => {
    try {
        const { name, itemPrice } = req.body;

        if (
            typeof name !== "string" ||
            name.trim() === "" ||
            !Number.isInteger(itemPrice) ||
            itemPrice < 0
        ) {
            return res.status(400).json({
                message:
                    "Name is required and itemPrice must be a non-negative integer"
            });
        }

        const pool = await poolPromise;

        const result = await pool
            .request()
            .input("name", sql.NVarChar(100), name.trim())
            .input("itemPrice", sql.Int, itemPrice)
            .query(`
                INSERT INTO Product (Name, ItemPrice)
                OUTPUT
                    INSERTED.ID,
                    INSERTED.Name,
                    INSERTED.ItemPrice
                VALUES (@name, @itemPrice)
            `);

        res.status(201).json({
            message: "Product created successfully",
            product: result.recordset[0]
        });
    } catch (error) {
        console.error("Create product error:", error);

        res.status(500).json({
            message: "Could not create the product"
        });
    }
});

// Unknown endpoint
app.use((req, res) => {
    res.status(404).json({
        message: "API endpoint not found"
    });
});

// Start the server only after checking the database connection
async function startServer() {
    try {
        await poolPromise;

        app.listen(PORT, () => {
            console.log(`Server running on port ${PORT}`);
        });
    } catch (error) {
        console.error("Server failed to start:", error);
        process.exit(1);
    }
}

startServer();