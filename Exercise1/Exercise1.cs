using System;

namespace StringExercises
{
  class Exercise1
  {
    static void Main(string[] args)
    {
      Console.WriteLine("=== Exercise 1: Variable Declaration and Initialization ===");

      // TODO: Declare and initialize string variables for personal information
      // Requirements:
      // 1. Declare a string variable called 'firstName' and initialize it with any first name
      // 2. Declare a string variable called 'lastName' and initialize it with any last name
      // 3. Declare a string variable called 'email' and initialize it with any email address
      // 4. Declare a string variable called 'phoneNumber' and initialize it with any phone number
      // 5. Declare a string variable called 'address' and initialize it with any address

      // YOUR CODE HERE - START
      string firstName = "Jones";
      string lastName = "Osei";
      string email = "jones.osei.gmail.com";
      string phoneNumber = "123-456-7890";
      string address = "1234 Brunswick Street";

      // YOUR CODE HERE - END

      // TODO: Display all the information using Console.WriteLine
      // Requirements:
      // 6. Display "Personal Information:" as a header
      // 7. Display each piece of information with a label (e.g., "First Name: John")

      // YOUR CODE HERE - START
      Console.WriteLine("Personal Information:");
      Console.WriteLine("First Name: " + firstName);
      Console.WriteLine("Last Name: " + lastName);
      Console.WriteLine("Email: " + email);
      Console.WriteLine("Phone: " + phoneNumber);
      Console.WriteLine("Address: " + address);

      // YOUR CODE HERE - END

      Console.WriteLine("\nPress any key to exit...");
      Console.ReadKey();
    }
  }
}
