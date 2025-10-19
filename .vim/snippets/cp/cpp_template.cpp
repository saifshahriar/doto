/*
 * Author: Saif Shahriar
 */

#define InTheNameofAllah ios::sync_with_stdio(0), cin.tie(0);
/// {{{ Helper
// clang-format off
#ifdef ONPC
// #define _GLIBCXX_DEBUG
#include <bits/_ojdebug.h>
#define debug(x) cerr << #x <<" "; _print(x); cerr << endl;
#else
#include <bits/stdc++.h>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
#define debug(x)
using namespace std;
using namespace __gnu_pbds;
#endif

/* macros */
#define el              '\n'
#define len(x)          ((int)((x).size()))
#define all(x)          (x).begin(), (x).end()
#define rall(x)         (x).rbegin(), (x).rend()
#define getbit(n, i)    (((n) & (1LL << (i))) != 0)
#define setbit0(n, i)   ((n) & (~(1LL << (i))))
#define setbit1(n, i)   ((n) | (1LL << (i)))
#define togglebit(n, i) ((n) ^ (1LL << (i)))
#define lsb(n)          ((n) & (-(n)))
#define msb_pos(n)      ((x) == 0 ? -1 : 31 - __builtin_clzll(x))
#define yes             cout << "yes\n"
#define Yes             cout << "Yes\n"
#define YES             cout << "YES\n"
#define NO              cout << "NO\n"
#define no              cout << "no\n"
#define No              cout << "No\n"
#define __true          cout << "true\n"
#define __True          cout << "True\n"
#define __false         cout << "false\n"
#define __False         cout << "False\n"

/* typedefs */
using ll  = long long;
using ull = unsigned long long;
using ld  = long double;
using u8  = uint8_t;
using u16 = uint16_t;
using u32 = uint32_t;
using u64 = uint64_t;
using i8  = int8_t;
using i16 = int16_t;
using i32 = int32_t;
using i64 = int64_t;

/* custom data types */
#ifndef ONPC
template <typename T> using ordered_set =
    tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;
#if __cplusplus >= 201402L
template <typename T> struct ordered_multiset {
	ordered_set<pair<T, int>> vals;
	set<pair<T, int>>         best; /* start at -1 */

	/* helper, find the lowest value that represents the element */
	int findbest(T val) { return (*best.upper_bound(make_pair(val - 1, 0))).second; }

	/* is element in set */
	bool contains(T val) { return vals.find(make_pair(val, -1)) != vals.end(); }

	void insert(T val) {
		if (contains(val)) { /* already in, update lowest value and insert a new one */
			int loc = findbest(val);
			best.erase(make_pair(val, loc));
			best.insert(make_pair(val, loc - 1));
			vals.insert(make_pair(val, loc - 1));
		} else { /* make lowest value -1 and insert it */
			best.insert(make_pair(val, -1));
			vals.insert(make_pair(val, -1));
		}
	}

	void erase(T val) { /* erases one */
		if (!contains(val))
			return;     /* not in */
		T loc = findbest(val);

		/* remove the element and its best */
		best.erase(make_pair(val, loc));
		vals.erase(make_pair(val, loc));
		if (loc != -1)
			best.insert(make_pair(val, loc + 1)); /* more elements in set, update best */
	}

	/* unmodified functions */
	T find_by_order(int k) { return (*vals.find_by_order(k)).first; }
	int order_of_key(T k) { return vals.order_of_key(make_pair(k - 1, 0)); }
	auto begin() { return vals.begin(); }
	auto end() { return vals.end(); }
	auto rbegin() { return vals.rbegin(); }
	auto rend() { return vals.rend(); }
	int size() { return vals.size(); }
	void clear() { vals.clear(); best.clear(); }
	int count(T k) { return vals.order_of_key({ k, 0 }) - vals.order_of_key({ k - 1, 0 }); }
	auto lower_bound(T k) { return vals.lower_bound(make_pair(k - 1, 0)); }
	auto upper_bound(T k) { return vals.upper_bound(make_pair(k, 0)); }
};
#endif
#endif

/* constants */
constexpr int       MOD   = 1e9 + 7;
constexpr int       MX    = 2e5 + 5;
constexpr long long INF   = 1e18;
constexpr int       N     = 2e5 + 5;
constexpr double    EPS   = 1e-9;
constexpr int       dx[4] = { 0, 1, -1, 0 };
constexpr int       dy[4] = { -1, 0, 0, 1 };

/* templates */
#if __cplusplus < 201402L
template <typename Container, typename BinaryOp>
typename decay<decltype(*begin(declval<Container>()))>::type
sum(const Container& c, BinaryOp op) {
    typedef typename decay<decltype(*c.begin())>::type T;
    return std::accumulate(c.begin(), c.end(), T(0), op);
}

template <typename Container>
typename decay<decltype(*begin(declval<Container>()))>::type
sum(const Container& c) {
    typedef typename decay<decltype(*c.begin())>::type T;
    return std::accumulate(c.begin(), c.end(), T(0));
}

template <typename Container>
typename decay<decltype(*begin(declval<Container>()))>::type
prod(const Container& c) {
    typedef typename decay<decltype(*c.begin())>::type T;
    return std::accumulate(c.begin(), c.end(), T(1), std::multiplies<T>());
}
#else
template <typename Container, typename BinaryOp = plus<>>
auto sum(const Container& c, BinaryOp op = {}) {
	using T = typename decay<decltype(*c.begin())>::type;
	return accumulate(c.begin(), c.end(), T { 0 }, op);
}

template <typename Container> auto prod(const Container& c) {
	using T = typename decay<decltype(*c.begin())>::type;
	return accumulate(c.begin(), c.end(), T { 1 }, multiplies<>());
}
#endif

template <typename T> vector<vector<T> > gps(const vector<T>& v) {
	return accumulate(v.begin(), v.end(), vector<vector<T> > { {} },
	                  [](vector<vector<T> > acc, const T& x) {
		                  vector<vector<T> > sets = acc;
		                  for (auto& e : acc) {
			                  auto ns = e;
			                  ns.push_back(x);
			                  sets.push_back(ns);
		                  }
		                  return sets;
	                  });
}

struct uniq_t {
    template<class T> friend T operator|(T v, const uniq_t&) {
        sort(v.begin(), v.end());
        v.erase(unique(v.begin(), v.end()), v.end());
        return v;
    }
} uniq;

namespace Saif {
	struct range {
		int l, r;
		struct iterator {
			int val;
			int operator*() const { return val; }
			bool operator!=(const iterator &other) const { return val != other.val; }
			void operator++() { ++val; }
		};
		iterator begin() const { return { l }; }
		iterator end() const { return { r }; }
	};
};

inline Saif::range range(int r) { return Saif::range{ 0, r }; }
inline Saif::range range(int l, int r) { return Saif::range{ l, r }; }

/* helper functions */
mt19937 rnd(chrono::steady_clock::now().time_since_epoch().count());

// mod
inline long long mod_add(long long a, long long b, long long m = MOD) { return (a + b) % m; }
inline long long mod_sub(long long a, long long b, long long m = MOD) { return (a - b + m) % m; }
inline long long mod_mul(long long a, long long b, long long m = MOD) { return (a * b) % m; }
long long mod_pow(long long a, long long b, long long m = MOD) {
	long long res  = 1;
	a             %= m;
	while (b) {
		if (b & 1)
			res = mod_mul(res, a, m);
		a   = mod_mul(a, a, m);
		b >>= 1;
	}
	return res;
}
long long mod_inv(long long a, long long m = MOD) { return mod_pow(a, m - 2, m); }

// clang-format on
/// }}}

/* #define TESTCASES */
/* #define PRINTCASES */
/* #define LIGHTOJ */

void sol() {
}

/// {{{ Main
// clang-format off
int32_t main() {
	InTheNameofAllah
	int testcases = 1;
	#ifdef TESTCASES
	cin >> testcases;
	#endif
	for (int i = 1; i <= testcases; ++i) {
		#ifdef PRINTCASES
		cout << "Case " << i << ":\n";
		#elif LIGHTOJ
		cout << "Case " << i << ": ";
		#endif
		sol();
	}
}
// vim: foldmethod=marker
/// }}}
