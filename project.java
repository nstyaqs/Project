public class project{
    public static void main(String[] args) {
        String input = "2 10 0";
        String[] numbers = input.split(" ");

        String[] binaryNumbers = toBin(numbers);

        System.out.println(Median(bubbleSort(binaryNumbers)));
        System.out.println(Average(bubbleSort(binaryNumbers)));

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

    public static String[] bubbleSort(String[] arr){
        int n = arr.length;
        for(int i=0; i< n-1; i++){
            for(int j =0; j < n-i-1; j++){
                if (arr[i].compareTo(arr[j])>0) {
                    String temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1]= temp;
                }
            }
        }
        return arr;
    }

    public static int binToDec(String binNum){
        int decimal = 0;
        int n = binNum.length();
        int sign =1;

        if (binNum.charAt(0)== '-') {
            sign = -1;
            binNum = binNum.substring(1);
            n--;
        }

        for (int i=0; i<n; i++){
            int digit = binNum.charAt(i)- '0';
            decimal += digit*Math.pow(2, n-i-1);
        }
        return decimal *sign;
    }

    public static double Median(String[] arr){
        if (arr.length %2 == 0) {
            int mid1 = arr.length/2;
            int mid2 = mid1 -1;
            double num1 = binToDec(arr[mid1]);
            double num2 = binToDec(arr[mid2]);

            return (num1+ num2)/2;
        }else{
            int mid = arr.length/2;
            return binToDec(arr[mid]);
        }
    }

    public static double Average(String[] numbers){
        int sum =0;
        int count =0;
        for(String num: numbers){
            int decNum = binToDec(num);
            sum+= decNum;
            count++;
        }
        if (count == 0) {
            return 0;
        } else{
            return (double) sum/count;
        }
    }
}