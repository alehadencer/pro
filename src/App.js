import React, { useState } from 'react';
import './App.css';

function App() {
  const [redCount, setRedCount] = useState(0);
  const [blueCount, setBlueCount] = useState(0);

  return (
    <div className="App">
      <header className="App-header">
        <button
          style={{ backgroundColor: '#ff4646', color: '#fff' }}
          onClick={() => setRedCount(redCount + 1)}
        >
          Red Button
        </button>
        <button
          style={{ backgroundColor: '#007bff', color: '#fff' }}
          onClick={() => setBlueCount(blueCount + 1)}
        >
          Blue Button
        </button>
        <p id="clickCountRed">Red Count: {redCount}</p>
        <p id="clickCountBlue">Blue Count: {blueCount}</p>
      </header>
    </div>
  );
}

export default App;