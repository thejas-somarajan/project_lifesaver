#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Fonts/FreeSerif12pt7b.h>
#include <SoftwareSerial.h>

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels

SoftwareSerial bluetoothSerial(2, 3); // RX, TX

// Declaration for an SSD1306 display connected to I2C (SDA, SCL pins)
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);

void setup() {
  Serial.begin(115200);

  startingup();

  // Initialize software serial for Bluetooth communication
  bluetoothSerial.begin(9600);

  // Set pin mode for built-in LED
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  // Check if data is available to read from Bluetooth
  int result = 0;
  if (bluetoothSerial.available() > 0) {
    // Read the incoming byte
    char command = bluetoothSerial.read();
    result = connect(command);
    interface_simulation(result);
  }
}
