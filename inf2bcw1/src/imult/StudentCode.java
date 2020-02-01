package imult;

import java.io.File;
import java.lang.Math;

/*
 * Class StudentCode: class for students to implement
 * the specific methods required by the assignment:
 * add()
 * sub()
 * koMul()
 * koMulOpt()
 * (See coursework handout for full method documentation)
 */

public class StudentCode {
	public static BigInt add(BigInt A, BigInt B) {
		// Finds the maximum of the two numbers
		int length = Math.max(A.length(), B.length());

		BigInt sum = new BigInt();
		Unsigned carry = new Unsigned(0);

		// adding A and B together considering the carry
		for (int i = 0; i <= length; i++) {
			DigitAndCarry new_digit = Arithmetic.addDigits(A.getDigit(i), B.getDigit(i), carry);
			// setting the digit
			sum.setDigit(i, new_digit.getDigit());
			// updating the carry
			carry = new_digit.getCarry();
		}

		return sum;
	}

	public static BigInt sub(BigInt A, BigInt B) {
		// Finds the maximum of the two numbers
		int length = Math.max(A.length(), B.length());

		BigInt minus = new BigInt();
		Unsigned carry = new Unsigned(0);
		// subtracting A and B together considering the carry
		for (int i = 0; i <= length; i++) {
			DigitAndCarry new_digit = Arithmetic.subDigits(A.getDigit(i), B.getDigit(i), carry);
			// setting the digit
			minus.setDigit(i, new_digit.getDigit());
			// updating the carry
			carry = new_digit.getCarry();
		}

		return minus;

	}

	public static BigInt koMul(BigInt A, BigInt B) {
		// Finds the maximum of the two numbers
		int length = Math.max(A.length(), B.length());

		BigInt multiply = new BigInt();
		// Base case- if the length is less than 2
		if (A.length() <= 1 && B.length() <= 1) {
			// multiplying two digits together
			DigitAndCarry new_digit = Arithmetic.mulDigits(A.getDigit(0), B.getDigit(0));
			// setting the digits
			multiply.setDigit(0, new_digit.getDigit());
			multiply.setDigit(1, new_digit.getCarry());

		} else {
			// calculating where to split A and B
			int split = (int) Math.floor(length / 2);
			// calculating alph_0 and alpha_1
			BigInt alpha_0 = A.split(0, split - 1);
			BigInt alpha_1 = A.split(split, length);
			// calculating beta_0 and beta_1
			BigInt beta_0 = B.split(0, split - 1);
			BigInt beta_1 = B.split(split, length);

			BigInt l = koMul(alpha_0, beta_0);
			BigInt h = koMul(alpha_1, beta_1);
			BigInt a = add(alpha_0, alpha_1);
			BigInt b = add(beta_0, beta_1);
			// step m
			BigInt m = sub(koMul(a, b), add(l, h));
			// multiplying m by the base
			m.lshift(split);
			// multiplying h by base^2
			h.lshift(2 * split);
			// adding all the components together
			multiply = add(add(l, m), h);

		}

		return multiply;

	}

	public static BigInt koMulOpt(BigInt A, BigInt B) {
		// Finding the shortest length of A and B
		int short_length = Math.min(A.length(), B.length());

		BigInt multiply = new BigInt();
		// if length is shorter than 10 then use the school method
		// Meet the assertion for schoolMul
		if (short_length <= 10 && (A.length() == B.length())) {

			multiply = Arithmetic.schoolMul(A, B);
		} else {
			// same method as KoMul

			int length = Math.max(A.length(), B.length());

			if (A.length() <= 1 && B.length() <= 1) {

				DigitAndCarry new_digit = Arithmetic.mulDigits(A.getDigit(0), B.getDigit(0));

				multiply.setDigit(0, new_digit.getDigit());
				multiply.setDigit(1, new_digit.getCarry());

			} else {
				int split = (int) Math.floor(length / 2);

				BigInt alpha_0 = A.split(0, split - 1);
				BigInt alpha_1 = A.split(split, length);

				BigInt beta_0 = B.split(0, split - 1);
				BigInt beta_1 = B.split(split, length);

				BigInt l = koMulOpt(alpha_0, beta_0);
				BigInt h = koMulOpt(alpha_1, beta_1);
				BigInt a = add(alpha_0, alpha_1);
				BigInt b = add(beta_0, beta_1);

				BigInt m = sub(koMulOpt(a, b), add(l, h));
				m.lshift(split);
				h.lshift(2 * split);

				multiply = add(add(l, m), h);

			}
		}
		return multiply;
	}

	public static void main(String argv[]) throws java.io.FileNotFoundException {
		// File koMulOptTimes = new File("koMulOptTimes.txt");
		// File ratio = new File("ratio.txt");
		//
		// BigIntMul.getRunTimes(new Unsigned(1), new Unsigned(10), new Unsigned(90),
		// koMulOptTimes, true);
		// BigIntMul.getRatios(new Unsigned(1), new Unsigned(10), new Unsigned(90),
		// ratio, new Unsigned(90));
		// File plot = new File("plot.jpg");
		// double c = 0.0025320658149564257;
		// double a = 0.0017471073721337914;
		// BigIntMul.plotRunTimes(c, a, koMulOptTimes);
		// // add(new BigInt("7867 6876"), new BigInt("7655 6565")).print();
		// // sub(new BigInt("7867 6876"), new BigInt("7655 6565")).print();

		// // koMul(new BigInt ("5 4321"), new BigInt ("9 8760")).print();
		// koMul(new BigInt("1007 0404"), new BigInt("2060 0501")).print();
		// koMul(new BigInt("1000 0000"), new BigInt("1000 0000")).print();
		// BigInt c = new BigInt ("0103");
		// System.out.println(c.length());
		// Unsigned m = new Unsigned(4);
		// Unsigned n = new Unsigned(1);
		// System.out.print(BigIntMul.mulVerify(new BigInt ("78"),new BigInt ("76"), new
		// BigInt("5928")));
		// ("5928"));
		// Unsigned m = new Unsigned(200);
		// Unsigned n = new Unsigned(1);
		// BigIntMul.mulTest(m,n);
	}
} // end StudentCode class
