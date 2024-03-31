/*const express = require('express');
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

const patientSchema = new mongoose.Schema({
  name: String,
  dob: Date,
  gender: String,
  medicalCase: String,
  tests: [{
    date: Date,
    type: String,
    result: String
  }]
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
// Route to get all patients
app.get('/patients', async (req, res) => {
  try {
    // Retrieve all patients from the database
    const patients = await Patient.find();

    // Respond with the retrieved patients
    res.status(200).json(patients);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});
// Route to delete a patient by ID
app.delete('/patients/:id', async (req, res) => {
  try {
    const { id } = req.params;
    // Find the patient by ID and delete it from the database
    await Patient.findByIdAndDelete(id);
    res.status(200).json({ message: 'Patient deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});




// Route to add a test for a particular patient
app.post('/patients/:id/tests', async (req, res) => {
  try {
    const { id } = req.params;
    const { date, type, result } = req.body;

    // Find the patient by ID
    const patient = await Patient.findById(id);
    if (!patient) {
      return res.status(404).json({ error: 'Patient not found' });
    }

    // Add the test to the patient's tests array
    patient.tests.push({ date, type, result });
    await patient.save();

    res.status(201).json(patient);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Route to get all tests for a particular patient
app.get('/patients/:id/tests', async (req, res) => {
  try {
    const { id } = req.params;

    // Find the patient by ID
    const patient = await Patient.findById(id);
    if (!patient) {
      return res.status(404).json({ error: 'Patient not found' });
    }

    // Respond with the tests for the patient
    res.status(200).json(patient.tests);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});
*/
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const bcrypt = require('bcrypt');

const app = express();
const PORT = 3000;

// Connect to MongoDB
mongoose.connect('mongodb+srv://grouppresentationmapd725:grouppresentationmapd725@cluster2.4uzshkh.mongodb.net/', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Define Patient schema
/*const patientSchema = new mongoose.Schema({
  name: String,
  dob: Date,
  gender: String,
  medicalCase: String,
  tests: [{
    date: Date,
    type: String,
    result: String
  }]
});
*/
const testSchema = new mongoose.Schema({
  patient_id: String,
  date: Date,
  type: String,
  result: String
  
});

const patientSchema = new mongoose.Schema({
  name: String,
  dob: Date,
  gender: String,
  medicalCase: String,
  tests:[testSchema]
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

// Route to get all patients
app.get('/patients', async (req, res) => {
  try {
    // Retrieve all patients from the database
    const patients = await Patient.find();

    // Respond with the retrieved patients
    res.status(200).json(patients);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Route to delete a patient by ID
app.delete('/patients/:id', async (req, res) => {
  try {
    const { id } = req.params;
    // Find the patient by ID and delete it from the database
    await Patient.findByIdAndDelete(id);
    res.status(200).json({ message: 'Patient deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});



// Create a new test record for a patient
app.post('/patients/:id/tests', function (req, res, next) {
  console.log('POST /patients/:id/tests params=>' + JSON.stringify(req.params));
  console.log('POST /patients/:id/tests body=>' + JSON.stringify(req.body));
console.log(req.body)

let newTest = {
    patient_id: req.params.id,
    date: req.body.date, 
    type: req.body.type,
    result: req.body.result,
    
};
Patient.findOne({ _id: req.params.id })
  .then(patientObj => {
    patientObj.tests.push(newTest);
    return patientObj.save();
  })
  .then(patientObj => {
    console.log('patientObj updated');
    res.json(patientObj);
  })
  .catch(err => {
    if (err) throw err;
  });


})



// Route to get all tests for a particular patient
app.get('/patients/:id/tests', async (req, res) => {
  try {
    const { id } = req.params;

    // Find the patient by ID
    const patient = await Patient.findById(id);
    if (!patient) {
      return res.status(404).json({ error: 'Patient not found' });
    }

    // Respond with the tests for the patient
    res.status(200).json(patient.tests);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});


// Update a test record for a patient
app.put('/patients/:patientId/tests/:testId', function (req, res, next) {
  const { patientId, testId } = req.params;
  const { date, type, result } = req.body;

  Patient.findById(patientId)
    .then(patient => {
      if (!patient) {
        return res.status(404).json({ error: 'Patient not found' });
      }

      const testToUpdate = patient.tests.id(testId);
      if (!testToUpdate) {
        return res.status(404).json({ error: 'Test not found' });
      }

      // Update test properties
      if (date) testToUpdate.date = date;
      if (type) testToUpdate.type = type;
      if (result) testToUpdate.result = result;

      return patient.save();
    })
    .then(updatedPatient => {
      res.json(updatedPatient);
    })
    .catch(err => {
      console.error(err);
      res.status(500).json({ error: 'Internal server error' });
    });
});


// Delete a test record for a patient
app.delete('/patients/:patientId/tests/:testId', function (req, res, next) {
  const { patientId, testId } = req.params;

  Patient.findByIdAndUpdate(patientId, { $pull: { tests: { _id: testId } } })
    .then(updatedPatient => {
      if (!updatedPatient) {
        return res.status(404).json({ error: 'Patient not found' });
      }
      res.json(updatedPatient);
    })
    .catch(err => {
      console.error(err);
      res.status(500).json({ error: 'Internal server error' });
    });
});



//Customer Register



// Define Customer schema
const customerSchema = new mongoose.Schema({
  firstName: { type: String, required: true },
  lastName: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
});

const Customer = mongoose.model('Customers', customerSchema);

// Registration endpoint
app.post('/register', async (req, res) => {
  try {
    const { firstName, lastName, email, password } = req.body;

    // Check if email is already registered
    const existingCustomer = await Customer.findOne({ email });
    if (existingCustomer) {
      return res.status(400).json({ error: 'Email is already registered' });
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Create a new customer
    const newCustomer = new Customer({
      firstName,
      lastName,
      email,
      password: hashedPassword,
    });

    // Save the customer to the database
    await newCustomer.save();

    res.status(201).json({ message: 'Registration successful' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Endpoint to get all registered customers
/*app.get('/register', async (req, res) => {
  try {
    const customers = await Customer.find();
    res.status(200).json(customers);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});*/

app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Find the customer by email
    const customer = await Customer.findOne({ email });

    if (!customer) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Compare passwords
    const isPasswordMatch = await bcrypt.compare(password, customer.password);

    if (!isPasswordMatch) {
      return res.status(401).json({ error: 'Incorrect password' });
    }

    // If login successful, return success message
    res.status(200).json({ message: 'Login successful' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal server error' });
  }
});
