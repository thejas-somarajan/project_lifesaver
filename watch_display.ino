void startingup() {
  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) { // Address 0x3D for 128x64
    Serial.println(F("SSD1306 allocation failed"));
    for(;;);
  }

  delay(2000);

  display.clearDisplay();
  display.fillRoundRect(5, 5, 10, 20, 2, WHITE);
  display.display();
  delay(2000);

  display.fillRoundRect(20, 5, 10, 20, 2, WHITE);
  display.display();
  delay(2000);

  display.fillRoundRect(35, 5, 10, 20, 2, WHITE);
  display.display();
  delay(2000);

  display.fillRoundRect(50, 5, 10, 20, 2, WHITE);
  display.display();
  delay(2000);

  display.fillRoundRect(65, 5, 10, 20, 2, WHITE);
  display.display();
  delay(3000);

  display.clearDisplay();
  display.setTextSize(2);
  display.setTextColor(WHITE);
  display.setCursor(10, 20);
  // Display static text

  display.println("Lifesaver");
  display.display();

}

int connect(char command)
{
  if(command == '0')
  {
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Connected to Vivo");
    display.display();
    return 1;
  } 
  else if (command == '1')
  {
   display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("hemmorrhage detected");
    display.setTextSize(2);
    display.println("stage 1");
    display.display(); 
    return 1;
  }
  else if (command == '2')
  {
   display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Reached stage 2");
    display.setTextSize(2);
    display.println("Nausea alert");
    display.display(); 
    return 1;
  }
  else if (command == '3')
  {
   display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Reached stage 3");
    display.setTextSize(2);
    display.println("Unconscious alert");
    display.display(); 
    return 1;
  }
  else if (command == '4')
  {
   display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Reached stage 4");
    display.setTextSize(2);
    display.println("Critical");
    display.display(); 
    return 1;
  }
  else if (command == 's')
  {
   display.clearDisplay();
    display.setTextSize(1);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Sms sent to");
    display.setTextSize(2);
    display.println("6238637381");
    display.display(); 
    return 1;
  }
  else if (command == 'm')
  {
   display.clearDisplay();
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.setTextSize(2);
    display.println("SMS Sent");
    display.display(); 
    return 1;
  }
}


void interface_simulation(int result)
{

    if(result == 1)
    {
    delay(5000);
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Heart Rate");
    display.setTextSize(1);
    display.println("128 bpm");
    display.display();

    delay(5000);

    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("EDA");
    display.setTextSize(1);
    display.println("1.5 p");
    display.display();

    delay(5000);

    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Temperature");
    display.setTextSize(1);
    display.println("36 c");
    display.display();


    delay(5000);

    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("Oxy Sat");
    display.setTextSize(1);
    display.println("96 %");
    display.display();


    delay(5000);

    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0, 10);
    // Display static text
    display.println("BP");
    display.setTextSize(1);
    display.println("120/60");
    display.display();
    }
}