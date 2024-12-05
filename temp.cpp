#include <bits/stdc++.h>
using namespace std;

#define ll long long

// Constants
#define file ""

// Math.
/*
    1. Sum of the first n natural numbers:
       Formula: S = n * (n + 1) / 2

       C++ code:
       int sum_n(int n) {
           return n * (n + 1) / 2;
       }

    2. Sum of the squares of the first n natural numbers:
       Formula: S = n * (n + 1) * (2n + 1) / 6

       C++ code:
       int sum_of_squares(int n) {
           return n * (n + 1) * (2 * n + 1) / 6;
       }

    3. Sum of the cubes of the first n natural numbers:
       Formula: S = (n * (n + 1) / 2) ^ 2

       C++ code:
       int sum_of_cubes(int n) {
           int sum = n * (n + 1) / 2;
           return sum * sum;
       }

    4. Arithmetic Progression (AP) Sum:
       Formula: S = n * (first_term + last_term) / 2

       C++ code:
       int ap_sum(int first_term, int last_term, int n) {
           return n * (first_term + last_term) / 2;
       }

    5. Geometric Progression (GP) Sum:
       Formula (when r != 1): S = first_term * (1 - r^n) / (1 - r)

       C++ code:
       int gp_sum(int first_term, int r, int n) {
           if (r == 1) return first_term * n;
           return first_term * (1 - pow(r, n)) / (1 - r);
       }

    6. Sum of the first n terms of an arithmetic series:
       Formula: S_n = n / 2 * (2a + (n - 1) * d)
       where a is the first term and d is the common difference.

       C++ code:
       int arithmetic_series_sum(int a, int d, int n) {
           return n * (2 * a + (n - 1) * d) / 2;
       }

    7. Sum of the first n terms of a geometric series:
       Formula: S_n = a * (1 - r^n) / (1 - r), where a is the first term and r
   is the common ratio.

       C++ code:
       int geometric_series_sum(int a, int r, int n) {
           if (r == 1) return a * n;
           return a * (1 - pow(r, n)) / (1 - r);
       }

    8. Sum of an infinite geometric series (when |r| < 1):
       Formula: S = a / (1 - r)

       C++ code:
       int infinite_gp_sum(int a, float r) {
           if (fabs(r) >= 1) {
               // Sum does not exist if |r| >= 1
               return -1; // Indicating no sum
           }
           return a / (1 - r);
       }

    9. The nth term of an arithmetic sequence:
       Formula: nth_term = a + (n - 1) * d

       C++ code:
       int nth_term_ap(int a, int d, int n) {
           return a + (n - 1) * d;
       }

    10. The nth term of a geometric sequence:
        Formula: nth_term = a * r^(n-1)

        C++ code:
        int nth_term_gp(int a, int r, int n) {
            return a * pow(r, n - 1);
        }

    11. The sum of a finite geometric series:
        Formula: S_n = a * (1 - r^n) / (1 - r) (for r ≠ 1)

        C++ code:
        int sum_of_gp(int a, int r, int n) {
            if (r == 1) return a * n;
            return a * (1 - pow(r, n)) / (1 - r);
        }

    12. Factorial of a number (n!):
        Formula: n! = n * (n-1) * (n-2) * ... * 1

        C++ code:
        int factorial(int n) {
            int result = 1;
            for (int i = 1; i <= n; i++) {
                result *= i;
            }
            return result;
        }

    13. Combination (n choose k):
        Formula: C(n, k) = n! / (k! * (n - k)!)

        C++ code:
        int combination(int n, int k) {
            return factorial(n) / (factorial(k) * factorial(n - k));
        }

    14. Permutation (n P k):
        Formula: P(n, k) = n! / (n - k)!

        C++ code:
        int permutation(int n, int k) {
            return factorial(n) / factorial(n - k);
        }

    15. Sum of a finite arithmetic series with the first and last terms:
        Formula: S = n * (first_term + last_term) / 2

        C++ code:
        int arithmetic_series_sum(int first_term, int last_term, int n) {
            return n * (first_term + last_term) / 2;
        }

    16. Sum of the first n odd numbers:
        Formula: S = n^2

        C++ code:
        int sum_of_odds(int n) {
            return n * n;
        }

    17. Sum of the first n even numbers:
        Formula: S = n * (n + 1)

        C++ code:
        int sum_of_evens(int n) {
            return n * (n + 1);
        }

    18. Fibonacci sequence (Nth term):
        Formula: F_n = F_(n-1) + F_(n-2), with base cases F_0 = 0, F_1 = 1

        C++ code (using recursion):
        int fibonacci(int n) {
            if (n <= 1) return n;
            return fibonacci(n - 1) + fibonacci(n - 2);
        }

    19. Geometric Series (Sum of first n terms):
        Formula: S = a * (1 - r^n) / (1 - r), when r ≠ 1

        C++ code:
        int gp_sum(int a, int r, int n) {
            if (r == 1) return a * n;
            return a * (1 - pow(r, n)) / (1 - r);
        }

    20. Arithmetic Mean of an arithmetic sequence:
        Formula: Mean = (first_term + last_term) / 2

        C++ code:
        double arithmetic_mean(int first_term, int last_term) {
            return (first_term + last_term) / 2.0;
        }

    21. nth term of a binomial expansion (a + b)^n:
        Formula: C(n, k) * a^(n-k) * b^k

        C++ code:
        int binomial_term(int n, int k, int a, int b) {
            return combination(n, k) * pow(a, n - k) * pow(b, k);
        }

    22. Sum of first n triangular numbers:
        Formula: S = n * (n + 1) * (n + 2) / 6

        C++ code:
        int sum_of_triangular_numbers(int n) {
            return n * (n + 1) * (n + 2) / 6;
        }

    23. Harmonic Series Sum:
        Formula: H_n = 1 + 1/2 + 1/3 + ... + 1/n

        C++ code:
        double harmonic_sum(int n) {
            double sum = 0;
            for (int i = 1; i <= n; i++) {
                sum += 1.0 / i;
            }
            return sum;
        }

    24. Sum of powers of 2:
        Formula: S = 2^0 + 2^1 + 2^2 + ... + 2^(n-1) = 2^n - 1

        C++ code:
        int sum_of_powers_of_two(int n) {
            return pow(2, n) - 1;
        }

    25. Sum of a finite geometric series (when r > 1):
        Formula: S_n = a * (r^n - 1) / (r - 1)

        C++ code:
        int finite_gp_sum(int a, int r, int n) {
            return a * (pow(r, n) - 1) / (r - 1);
        }

    26. Arithmetic Progression (AP) nth term:
        Formula: nth_term = first_term + (n - 1) * common_difference

        C++ code:
        int ap_nth_term(int first_term, int d, int n) {
            return first_term + (n - 1) * d;
        }

    27. Exponential growth formula (population growth, compound interest):
        Formula: P = P0 * e^(rt)

        C++ code:
        double exponential_growth(double P0, double r, double t) {
            return P0 * exp(r * t);
        }

    28. Compound Interest (CI) formula:
        Formula: A = P * (1 + r/n)^(nt)

        C++ code:
        double compound_interest(double P, double r, int n, int t) {
            return P * pow(1 + r / n, n * t);
        }

    29. Euler’s number (e):
        Formula: e = limit as n → ∞ of (1 + 1/n)^n

        C++ code:
        double euler_number(int n) {
            return pow(1 + 1.0/n, n);
        }

    30. Sum of the first n factorials:
        Formula: S = 0! + 1! + 2! + ... + n!

        C++ code:
        int sum_of_factorials(int n) {
            int sum = 0;
            for (int i = 0; i <= n; i++) {
                sum += factorial(i);
            }
            return sum;
        }

    31. Sum of cubes of the first n odd numbers:
        Formula: S = (n^2) * (n^2)

        C++ code:
        int sum_of_cubes_of_odds(int n) {
            return pow(n * n, 2);
        }

    32. Sum of the first n prime numbers:
        Formula: There is no simple closed formula, but one can use an algorithm
   to find the sum.

        C++ code:
        bool is_prime(int num) {
            if (num <= 1) return false;
            for (int i = 2; i * i <= num; i++) {
                if (num % i == 0) return false;
            }
            return true;
        }

        int sum_of_primes(int n) {
            int sum = 0, count = 0, num = 2;
            while (count < n) {
                if (is_prime(num)) {
                    sum += num;
                    count++;
                }
                num++;
            }
            return sum;
        }

    33. Sum of the first n Fibonacci numbers:
        Formula: S_n = F_0 + F_1 + F_2 + ... + F_n

        C++ code:
        int sum_of_fibonacci(int n) {
            int a = 0, b = 1, sum = a + b;
            for (int i = 2; i <= n; i++) {
                int next = a + b;
                sum += next;
                a = b;
                b = next;
            }
            return sum;
        }

    34. Sum of the first n perfect squares (sum of squares of integers):
        Formula: S = n * (n + 1) * (2n + 1) / 6

        C++ code:
        int sum_of_squares(int n) {
            return n * (n + 1) * (2 * n + 1) / 6;
        }

    35. Sum of the first n triangular numbers:
        Formula: T_n = n * (n + 1) / 2

        C++ code:
        int triangular_number(int n) {
            return n * (n + 1) / 2;
        }

    36. Euler's Totient Function (φ(n)):
        Formula: φ(n) = n * (1 - 1/p1) * (1 - 1/p2) * ... * (1 - 1/pk)
        where p1, p2, ..., pk are the prime factors of n.

        C++ code:
        int euler_totient(int n) {
            int result = n;
            for (int i = 2; i * i <= n; i++) {
                if (n % i == 0) {
                    while (n % i == 0) n /= i;
                    result -= result / i;
                }
            }
            if (n > 1) result -= result / n;
            return result;
        }

    37. Sum of the first n odd numbers:
        Formula: S = n^2

        C++ code:
        int sum_of_odds(int n) {
            return n * n;
        }

    38. Sum of the first n even numbers:
        Formula: S = n * (n + 1)

        C++ code:
        int sum_of_evens(int n) {
            return n * (n + 1);
        }

    39. Sum of an infinite geometric series:
        Formula: S = a / (1 - r) where |r| < 1

        C++ code:
        double infinite_gp_sum(double a, double r) {
            if (fabs(r) >= 1) {
                return -1; // Sum doesn't exist
            }
            return a / (1 - r);
        }

    40. Arithmetic Progression (AP) nth term:
        Formula: T_n = a + (n - 1) * d

        C++ code:
        int ap_nth_term(int a, int d, int n) {
            return a + (n - 1) * d;
        }

    41. Binomial Expansion (a + b)^n term (kth term):
        Formula: T_k = C(n, k) * a^(n-k) * b^k

        C++ code:
        int binomial_expansion(int n, int k, int a, int b) {
            return combination(n, k) * pow(a, n - k) * pow(b, k);
        }

    42. Harmonic Mean (for two numbers a and b):
        Formula: HM = 2ab / (a + b)

        C++ code:
        double harmonic_mean(double a, double b) {
            return 2 * a * b / (a + b);
        }

    43. Sum of the first n natural numbers raised to the pth power:
        Formula: S = 1^p + 2^p + 3^p + ... + n^p

        C++ code:
        int sum_of_powers(int n, int p) {
            int sum = 0;
            for (int i = 1; i <= n; i++) {
                sum += pow(i, p);
            }
            return sum;
        }

    44. Fibonacci number using the closed-form expression (Binet's formula):
        Formula: F_n = (phi^n - (1-phi)^n) / sqrt(5), where phi = (1 + sqrt(5))
   / 2

        C++ code:
        int binet_fibonacci(int n) {
            const double phi = (1 + sqrt(5)) / 2;
            return round((pow(phi, n) - pow(1 - phi, n)) / sqrt(5));
        }

    45. Sum of cubes of the first n integers:
        Formula: S = (n * (n + 1) / 2)^2

        C++ code:
        int sum_of_cubes(int n) {
            int sum = n * (n + 1) / 2;
            return sum * sum;
        }

    46. Sum of first n multiples of a number k:
        Formula: S = k * (1 + 2 + 3 + ... + n) = k * n * (n + 1) / 2

        C++ code:
        int sum_of_multiples(int k, int n) {
            return k * n * (n + 1) / 2;
        }

    47. Arithmetic Mean (AM) of n numbers:
        Formula: AM = (a1 + a2 + a3 + ... + an) / n

        C++ code:
        double arithmetic_mean_of_n_numbers(int numbers[], int n) {
            double sum = 0;
            for (int i = 0; i < n; i++) {
                sum += numbers[i];
            }
            return sum / n;
        }

    48. Median of a set of numbers:
        Formula: The median is the middle value when the numbers are sorted. If
   there is an even number of elements, the median is the average of the two
   middle values.

        C++ code:
        double median_of_numbers(int numbers[], int n) {
            sort(numbers, numbers + n);
            if (n % 2 == 0) {
                return (numbers[n / 2 - 1] + numbers[n / 2]) / 2.0;
            } else {
                return numbers[n / 2];
            }
        }

    49. Sum of first n prime numbers:
        Formula: Sum = p1 + p2 + p3 + ... + pn, where p1, p2, ..., pn are the
   first n primes

        C++ code:
        bool is_prime(int num) {
            if (num <= 1) return false;
            for (int i = 2; i * i <= num; i++) {
                if (num % i == 0) return false;
            }
            return true;
        }

        int sum_of_primes(int n) {
            int sum = 0, count = 0, num = 2;
            while (count < n) {
                if (is_prime(num)) {
                    sum += num;
                    count++;
                }
                num++;
            }
            return sum;
        }

    50. Sum of first n Fibonacci numbers:
        Formula: Sum = F_0 + F_1 + F_2 + ... + F_n

        C++ code:
        int sum_of_fibonacci(int n) {
            int a = 0, b = 1, sum = a + b;
            for (int i = 2; i <= n; i++) {
                int next = a + b;
                sum += next;
                a = b;
                b = next;
            }
            return sum;
        }
*/

// Helper functions

ll modPow(ll base, ll exp, ll mod) {
  ll result = 1;
  while (exp > 0) {
    if (exp % 2 == 1)
      result = (result * base) % mod;
    base = (base * base) % mod;
    exp /= 2;
  }
  return result;
}

vector<bool> sievePrimes(ll limit) {
  vector<bool> isPrime(limit + 1, true);
  isPrime[0] = isPrime[1] = false;
  for (ll i = 2; i * i <= limit; ++i)
    if (isPrime[i])
      for (ll j = i * i; j <= limit; j += i)
        isPrime[j] = false;
  return isPrime;
}

bool isPrime(ll num) {
  if (num <= 1)
    return false;
  if (num <= 3)
    return true;
  if (num % 2 == 0 || num % 3 == 0)
    return false;
  for (ll i = 5; i * i <= num; i += 6)
    if (num % i == 0 || num % (i + 2) == 0)
      return false;
  return true;
}

ll digitSum(ll num) {
  ll sum = 0;
  while (num) {
    sum += num % 10;
    num /= 10;
  }
  return sum;
}

ll reverseNum(ll num) {
  ll reversed = 0;
  while (num) {
    reversed = reversed * 10 + (num % 10);
    num /= 10;
  }
  return reversed;
}

vector<ll> calculatePrefixSum(const vector<ll> &arr) {
  vector<ll> prefixSum(arr.size() + 1, 0);
  for (size_t i = 1; i <= arr.size(); ++i)
    prefixSum[i] = prefixSum[i - 1] + arr[i - 1];
  return prefixSum;
}

ll binarySearch(const vector<ll> &arr, ll target) {
  ll left = 0, right = arr.size() - 1;
  while (left <= right) {
    ll mid = left + (right - left) / 2;
    if (arr[mid] == target)
      return mid;
    else if (arr[mid] < target)
      left = mid + 1;
    else
      right = mid - 1;
  }
  return -1; // Element not found
}

ll gcd(ll a, ll b) {
  while (b != 0) {
    a %= b;
    swap(a, b);
  }
  return a;
}

ll lcm(ll a, ll b) { return a * b / gcd(a, b); }

ll countDivisors(ll n) {
  ll count = 0;
  for (ll i = 1; i * i <= n; ++i)
    if (n % i == 0) {
      count++;
      if (i != n / i)
        count++; // Count the paired divisor
    }
  return count;
}

map<ll, ll> primeFactorization(ll n) {
  map<ll, ll> factors; // factor, count
  for (ll i = 2; i * i <= n; ++i)
    while (n % i == 0) {
      factors[i]++;
      n /= i;
    }
  if (n > 1)
    factors[n]++; // n is prime
  return factors;
}

ll modInverse(ll a, ll mod) {
  return modPow(a, mod - 2, mod); // Fermat's little theorem: a^(mod-2) % mod
}

bool isPerfectSquare(ll num) {
  ll sqrtNum = sqrt(num);
  return sqrtNum * sqrtNum == num;
}

// Check if a number is a perfect cube
bool isPerfectCube(ll num) {
  ll cubeRoot = round(cbrt(num));
  return cubeRoot * cubeRoot * cubeRoot == num;
}

bool isPowerOfTwo(ll n) { return (n > 0) && (n & (n - 1)) == 0; }

ll minOfThree(ll a, ll b, ll c) { return min(a, min(b, c)); }

ll maxOfThree(ll a, ll b, ll c) { return max(a, max(b, c)); }

vector<ll> mergeSortedArrays(const vector<ll> &arr1, const vector<ll> &arr2) {
  vector<ll> result;
  ll i = 0, j = 0;
  while (i < arr1.size() && j < arr2.size()) {
    if (arr1[i] < arr2[j])
      result.push_back(arr1[i++]);
    else
      result.push_back(arr2[j++]);
  }
  while (i < arr1.size())
    result.push_back(arr1[i++]);
  while (j < arr2.size())
    result.push_back(arr2[j++]);
  return result;
}

bool isPalindrome(ll num) {
  ll original = num, reversed = 0;
  while (num > 0) {
    reversed = reversed * 10 + (num % 10);
    num /= 10;
  }
  return original == reversed;
}

ll countSetBits(ll n) {
  ll count = 0;
  while (n) {
    count += n & 1;
    n >>= 1;
  }
  return count;
}

// Remove duplicates from a vector
void removeDuplicates(vector<ll> &arr) {
  sort(arr.begin(), arr.end());
  arr.erase(unique(arr.begin(), arr.end()), arr.end());
}

int main() {
  cin.tie(0)->ios::sync_with_stdio(false);
  double startTime = clock();

  freopen(file ".INP", "r", stdin);
  // freopen(file".OUT", "w", stdout);

  double endTime = clock();
  cout << '\n' << (endTime - startTime) / CLOCKS_PER_SEC;

  return 0;
}
