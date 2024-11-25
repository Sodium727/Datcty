#pragma GCC optimize("O3")
#pragma GCC target("avx,avx2,fma")
#pragma GCC optimize("unroll-loops")
#include <bits/stdc++.h>

#define MAX_RECURSION_DEPTH 100000
#pragma GCC diagnostic ignored "-Wunused-function"
#include <ext/stdio_filebuf.h>

using namespace std;

typedef long long ll;
typedef vector < ll > vll;
typedef pair < ll, ll > pll;

// If you need to prints shits quickly.
#define DEBUG 0
#if DEBUG
#define debug(x) cerr << #x << " = " << x << endl;
#define debug(x) {
  \
  cerr << #x << " = ";\
  debug_print(x);\
}
template < typename T >
  void debug_print(const T & t) {
    cerr << t << endl;
  }
template < typename T, typename U >
  void debug_print(const pair < T, U > & p) {
    cerr << "(" << p.first << ", " << p.second << ")" << endl;
  }
template < typename T >
  void debug_print(const vector < T > & v) {
    for (const auto & e: v) cerr << e << " ";
    cerr << endl;
  }

#else
#define debug(x)
#endif

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

  // ll size;
  // cin >> size;

  // vll container(size);

  // for (ll i = 0; i < size; ++i) {
  //   cin >> container[i];
  // }

  return 0;
}
