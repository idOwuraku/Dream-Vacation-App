import express, { Express, Request, Response } from 'express';
import mysql, { Pool, RowDataPacket } from 'mysql2/promise';
import cors from 'cors';
import axios from 'axios';
import dotenv from 'dotenv';

dotenv.config();

interface Destination {
  id: number;
  country: string;
  capital?: string;
  population?: number;
  region?: string;
}


interface CountryAPIResponse {
    capital: string[];
    population: number;
    region: string;
}


const app: Express = express();
const port: number = parseInt(process.env.PORT || '3001', 10);

// Middlewares
app.use(cors());
app.use(express.json());

//MySQL Database Pool
const pool: Pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: parseInt(process.env.DB_PORT || '3306', 10),
});


const createTable = async (): Promise<void> => {
  const createTableQuery = `
    CREATE TABLE IF NOT EXISTS destinations (
      id INT AUTO_INCREMENT PRIMARY KEY,
      country VARCHAR(255) NOT NULL,
      capital VARCHAR(255),
      population BIGINT,
      region VARCHAR(255)
    );
  `;
  try {
    const connection = await pool.getConnection();
    await connection.query(createTableQuery);
    connection.release();
    console.log('Table "destinations" ensured.');
  } catch (err: any) {
    console.error('Error ensuring table "destinations":', err.message);
    process.exit(1); 
  }
};

createTable();

app.get('/api/destinations', async (req: Request, res: Response) => {
  try {
    const [rows] = await pool.query<Destination[] & RowDataPacket[]>('SELECT * FROM destinations ORDER BY id DESC');
    res.json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.post('/api/destinations', async (req: Request<{}, {}, { country: string }>, res: Response) => {
  const { country } = req.body;
  if (!country) {
    return res.status(400).json({ error: 'Country name is required' });
  }

  try {
    const response = await axios.get<CountryAPIResponse[]>(`${process.env.COUNTRIES_API_BASE_URL}/name/${encodeURIComponent(country)}`);
    const countryInfo = response.data[0];

    const [result] = await pool.query<mysql.ResultSetHeader>(
      'INSERT INTO destinations (country, capital, population, region) VALUES (?, ?, ?, ?)',
      [country, countryInfo.capital[0], countryInfo.population, countryInfo.region]
    );

    const newDestination: Destination = {
        id: result.insertId,
        country,
        capital: countryInfo.capital[0],
        population: countryInfo.population,
        region: countryInfo.region
    };
    res.status(201).json(newDestination);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.delete('/api/destinations/:id', async (req: Request<{ id: string }>, res: Response) => {
  const { id } = req.params;
  try {
    await pool.query('DELETE FROM destinations WHERE id = ?', [id]);
    res.status(204).send();
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

// One line change again and again and again and again