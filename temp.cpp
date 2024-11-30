#include <bits/stdc++.h>
using namespace std;

#define ll long long

// Constants
const ll MAX = LLONG_MAX;
const ll MOD = 1e9 + 7;
const bool useFile = 0;
#define file ""

// Helper functions

ll 
modPow(ll base, ll exp, ll mod)
{
  ll result = 1;
  while (exp > 0)
  {
    if (exp % 2 == 1)
      result = (result * base) % mod;
    base = (base * base) % mod;
    exp /= 2;
  }
  return result;
}

vector<bool> 
sievePrimes(ll limit)
{
  vector<bool> isPrime(limit + 1, true);
  isPrime[0] = isPrime[1] = false;
  for (ll i = 2; i * i <= limit; ++i)
    if (isPrime[i])
      for (ll j = i * i; j <= limit; j += i)
        isPrime[j] = false;
  return isPrime;
}

bool 
isPrime(ll num)
{
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

ll 
digitSum(ll num)
{
  ll sum = 0;
  while (num)
  {
    sum += num % 10;
    num /= 10;
  }
  return sum;
}

ll 
reverseNum(ll num)
{
  ll reversed = 0;
  while (num)
  {
    reversed = reversed * 10 + (num % 10);
    num /= 10;
  }
  return reversed;
}

vector<ll> 
calculatePrefixSum(const vector<ll>& arr)
{
  vector<ll> prefixSum(arr.size() + 1, 0);
  for (size_t i = 1; i <= arr.size(); ++i)
    prefixSum[i] = prefixSum[i - 1] + arr[i - 1];
  return prefixSum;
}

ll 
binarySearch(const vector<ll>& arr, ll target)
{
  ll left = 0, right = arr.size() - 1;
  while (left <= right)
  {
    ll mid = left + (right - left) / 2;
    if (arr[mid] == target)
      return mid;
    else if (arr[mid] < target)
      left = mid + 1;
    else
      right = mid - 1;
  }
  return -1;  // Element not found
}

ll 
gcd(ll a, ll b)
{
  while (b != 0)
  {
    a %= b;
    swap(a, b);
  }
  return a;
}

ll 
lcm(ll a, ll b)
{
  return a * b / gcd(a, b);
}

ll 
countDivisors(ll n)
{
  ll count = 0;
  for (ll i = 1; i * i <= n; ++i)
    if (n % i == 0)
    {
      count++;
      if (i != n / i)
        count++;  // Count the paired divisor
    }
  return count;
}

map<ll, ll> 
primeFactorization(ll n)
{
  map<ll, ll> factors; // factor, count
  for (ll i = 2; i * i <= n; ++i)
    while (n % i == 0)
    {
      factors[i]++;
      n /= i;
    }
  if (n > 1)
    factors[n]++;  // n is prime
  return factors;
}

ll 
modInverse(ll a, ll mod)
{
  return modPow(a, mod - 2, mod);  // Fermat's little theorem: a^(mod-2) % mod
}

bool 
isPerfectSquare(ll num)
{
  ll sqrtNum = sqrt(num);
  return sqrtNum * sqrtNum == num;
}

// Check if a number is a perfect cube
bool 
isPerfectCube(ll num)
{
  ll cubeRoot = round(cbrt(num));
  return cubeRoot * cubeRoot * cubeRoot == num;
}

bool 
isPowerOfTwo(ll n)
{
  return (n > 0) && (n & (n - 1)) == 0;
}

ll 
minOfThree(ll a, ll b, ll c)
{
  return min(a, min(b, c));
}

ll 
maxOfThree(ll a, ll b, ll c)
{
  return max(a, max(b, c));
}

vector<ll> 
mergeSortedArrays(const vector<ll>& arr1, const vector<ll>& arr2)
{
  vector<ll> result;
  ll i = 0, j = 0;
  while (i < arr1.size() && j < arr2.size())
  {
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

bool 
isPalindrome(ll num)
{
  ll original = num, reversed = 0;
  while (num > 0)
  {
    reversed = reversed * 10 + (num % 10);
    num /= 10;
  }
  return original == reversed;
}

ll 
countSetBits(ll n)
{
  ll count = 0;
  while (n)
  {
    count += n & 1;
    n >>= 1;
  }
  return count;
}

// Remove duplicates from a vector
void 
removeDuplicates(vector<ll>& arr)
{
  sort(arr.begin(), arr.end());
  arr.erase(unique(arr.begin(), arr.end()), arr.end());
}

// Count how many times a target appears in a vector
ll 
countOccurrences(const vector<ll>& arr, ll target)
{
  return count(arr.begin(), arr.end(), target);
}

int 
main()
{
  ios::sync_with_stdio(false);
  cin.tie(nullptr); cout.tie(nullptr);
 
  if (useFile) 
  {
    freopen(file".INP", "r", stdin);
    freopen(file".OUT", "w", stdout);
  }

  ll t;
  cin >> t;

  while (t--)
  {
    // Your logic here
  }

  return 0;
}
