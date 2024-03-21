const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const app = express();
const PORT = 3000;

// Connect to MongoDB
mongoose.connect('mongodb+srv://grouppresentationmapd725:grouppresentationmapd725@cluster2.4uzshkh.mongodb.net/', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Define Patient schema
const patientSchema = new mongoose.Schema({
  name: String,
  dob: Date,
  gender: String,
  medicalCase: String,
});

const Patient = mongoose.model('Patient', patientSchema);

app.use(bodyParser.json());

// Route to add a new patient
app.post('/patients', async (req, res) => {
  try {
    const { name, dob, gender, medicalCase } = req.body;
    const newPatient = new Patient({
      name,
      dob: new Date(dob),
      gender,
      medicalCase,
    });
    await newPatient.save();
    res.status(201).json(newPatient);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
