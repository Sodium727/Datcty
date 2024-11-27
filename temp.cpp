#pragma GCC optimize("O3")
#pragma GCC optimize("unroll-loops")
#include <bits/stdc++.h>

using namespace std;

typedef long long ll;
typedef vector<long long> vll;
typedef queue<ll> qll;
typedef pair<long long, long long> pll;

#define pb push_back         
#define mp make_pair        
#define fi first           
#define se second         
#define all(x) (x).begin(),(x).end()
#define rall(x) (x).rbegin(),(x).rend()
#define testCases long long t; cin >> t; while (t--)  
#define MOD 1000000007    
#define endl "\n"         
#define sz(x) (long long)(x).size() 
#define yes cout << "YES" << '\n' 
#define no cout << "NO" << '\n' 
#define out(val) cout << (val) << '\n'
#define in(val) cin >> (val)

// Literally cheating shits:

// inline ll 
// modPower(ll base, ll exp, ll mod) {
//   ll result = 1;
//   while (exp > 0) {
//     if (exp % 2 == 1) {
//       result = (result * base) % mod;
//     }
//     base = (base * base) % mod;
//     exp /= 2;
//   }
//   return result;
// }

// Binary Search
// inline ll 
// binarySearch(const vector<ll> & arr, ll target) {
//   ll left = 0, right = arr.size() - 1;
//   while (left <= right) {
//     ll mid = left + (right - left) / 2;
//     if (arr[mid] == target) return mid;
//     else if (arr[mid] < target) left = mid + 1;
//     else right = mid - 1;
//   }
//   return -1;
// }

// Prefix Sum
// inline vector<ll> 
// calculatePrefixSum(const vector<ll>& arr) {
//   vector<ll> prefix(arr.size() + 1, 0);
//   for (size_t i = 1; i <= arr.size(); ++i) {
//     prefix[i] = prefix[i - 1] + arr[i - 1];
//   }
//   return prefix;
// }

// Proper Divisors Sum
// inline vector<ll> 
// calculateDivisorSum(const ll& limit)
// {
//   vector<ll> divisorSum(limit + 1, 0);
//     for (ll i = 1; i < limit + 1; ++i)
//       for (ll j = 2 * i; j < limit + 1; j += i)
//         divisorSum[j] += i;
//
//   return divisorSum;
// }

// Count divisors
// inline vector<ll>
// countDivisor(const ll& limit)
// {
//   vector<ll> res(limit + 1, 0);
//   for (ll i = 1; i < limit + 1; ++i)
//     for (ll j = 2 * i; j < limit + 1; j += i)
//       ++res[j];
//
//   return res;
// }

// Sieve Primes
// vector<bool> 
// sievePrimes(const ll& limit)
// {
//   vector<bool> res(limit + 1, true);
//   res[0] = res[1] = false;
//   for (ll i = 2; i * i <= limit; ++i)
//     if (res[i])
//       for (ll j = i * i; j <= limit; j += i)
//         res[j] = false;
//   return res;
// }

// Check Primes
// inline bool 
// isPrime(const ll& num)
// {
//   if (num <= 1) return false;
//   if (num <= 3) return true;
//   if (num % 2 == 0 || num  % 3 == 0) return false;
//   for (ll i = 5; i * i <= num; i += 6)
//     if (num % i == 0 || num % (i + 2) == 0) 
//       return false;
//
//   return true;
// }

// Find Digit Sum
// inline ll
// calculateDigitSum(ll num)
// {
//   ll res = 0;
//   while (num)
//   {
//     res += num % 10;
//     num /= 10;
//   }
//   return res;
// }

// Reverse num
// inline ll
// reverseNum(ll num)
// {
//   ll res = 0;
//   while (num)
//   {
//     res = res * 10 + (num % 10);
//     num /= 10;
//   }
//   return res;
// }

// Perfect Square
// inline bool
// isPerfectSquare(const ll& num)
// {
//   return static_cast<ll>(sqrt(num)) * static_cast<ll>(sqrt(num)) == num;
// }

// File input
const string file = "";
bool useFiles = 0;

// Limit
// const ll MAX = static_cast<ll>(10e18);

int main() {
  ios::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  if (useFiles) {
    if (!freopen((file + ".INP").c_str(), "r", stdin)) return 1;
    if (!freopen((file + ".OUT").c_str(), "w", stdout)) return 1;
  }


  return 0;
}
