public class project{
    public static void main(String[] args) {
        String input = "2 10 0";
        String[] numbers = input.split(" ");

        String[] binaryNumbers = toBin(numbers);

    }

    public static String[] toBin(String[] numbers){
        String[] binNumbers = new String[numbers.length];
        for(int i=0; i< numbers.length; i++){
            int startNum =0;
            int sign = 1;

            String inputNum = numbers[i];
            for(int j=0; j< inputNum.length(); j++){ 
                char c = inputNum.charAt(j);
                if (c== '-' ) {
                    sign = -1;
                } else {
                    int digit = Character.getNumericValue(c);
                    startNum = startNum*10+digit;
                }
            }

            startNum *= sign;

            StringBuilder result = new StringBuilder();
            if (startNum ==0) {
                result.append("0");
            } else{
                while (startNum !=0) {
                    int remainder = Math.abs(startNum %2);
                    result.append(remainder);
                    startNum /= 2;
                }
            }

            if (sign == -1) {
                result.append("-");
            }

            binNumbers[i] = result.reverse().toString();
        }
        return binNumbers;
    }
}