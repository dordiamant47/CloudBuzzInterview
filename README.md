# CloudBuzzInterview

To access the API via browser:

1. Paste the following URL in your browser:

      https://f4vp31ydqi.execute-api.us-east-1.amazonaws.com/SumFunction?num1=<NUM_ONE>&num2=<NUM_TWO>

2. Replace the dynamic values of <NUM_ONE> and <NUM_TWO> in the URL with two numbers as you wish

3. You will get a JSON response that prints your two numbers, and the sum of them.


*Example:*
      
      For the URL :
      https://f4vp31ydqi.execute-api.us-east-1.amazonaws.com/SumFunction?num1=5&num2=42
      The result will be:
      {"num1": 5, "num2": 42, "Sum result": 47}
