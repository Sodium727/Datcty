#pragma GCC optimize("O3")
#pragma GCC target("avx,avx2,fma")
#pragma GCC optimize("unroll-loops")
#include <bits/stdc++.h>

#define MAX_RECURSION_DEPTH 100000
#pragma GCC diagnostic ignored "-Wunused-function"
#include <ext/stdio_filebuf.h>

using namespace std;

typedef long long ll;
typedef vector<long long> vll;
typedef pair<long long, long long> pll;
typedef unordered_map<long long, long long> mll;
typedef unordered_map<char, long long> mcll;

#define pb push_back         // push_back shorthand
#define mp make_pair         // make_pair shorthand
#define fi first             // shorthand for pair.first
#define se second            // shorthand for pair.second
#define all(x) (x).begin(),(x).end() // all elements of a container
#define rall(x) (x).rbegin(),(x).rend() // reverse iteration
#define FOR(i, a, b) for(long long i = a; i < b; i++)  // for loop from a to b
#define ROF(i, a, b) for(long long i = a; i >= b; i--) // reverse for loop
#define testCases long long t; cin >> t; while (t--)  
#define MOD 1000000007    
#define endl "\n"           // new line shorthand
#define sz(x) (long long)(x).size()  // size of a container
#define yes cout << "YES" << '\n' // output YES
#define no cout << "NO" << '\n' // output NO
#define out(val) cout << (val) << '\n'
#define in(val) cin >> (val)

// Literally cheating shits:

// ll mod_exp(ll base, ll exp, ll mod) {
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
// bool binary_search(const vector < ll > & arr, ll target) {
//   ll left = 0, right = arr.size() - 1;
//   while (left <= right) {
//     ll mid = left + (right - left) / 2;
//     if (arr[mid] == target) return true;
//     else if (arr[mid] < target) left = mid + 1;
//     else right = mid - 1;
//   }
//   return false;
// }

// Prefix Sum
// vector < ll > prefix_sum(const vector < ll > & arr) {
//   vector < ll > prefix(arr.size() + 1, 0);
//   for (size_t i = 1; i <= arr.size(); ++i) {
//     prefix[i] = prefix[i - 1] + arr[i - 1];
//   }
//   return prefix;
// }

// Proper Divisors Sum
// inline vector<ll> 
// calculateDivisorSum(const ll& _MAX)
// {
//   vector<ll> divisorSum(_MAX + 1, 0);
//     for (ll i = 1; i < _MAX + 1; ++i)
//       for (ll j = 2 * i; j < _MAX + 1; j += i)
//         divisorSum[j] += i;
//
//   return divisorSum;
// }


// File input?
const string file = "";
bool useFiles = false;

// Limit?
const ll MAX = LLONG_MAX;

int main() {
  ios::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  if (useFiles) {
    freopen((file + ".INP").c_str(), "r", stdin);
    freopen((file + ".OUT").c_str(), "w", stdout);
  }


  return 0;
}
