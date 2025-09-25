/*
 * Author: Saif Shahriar
 *
 * Put this header file in your compiler library path.
 * Make it precompiled .ghc before using for faster execution:
 *     doas g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -O2 -DONPC -H -x c++-header ./stdc++.h
 *     doas g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -O2 -DONPC -H -x c++-header ./_ojdebug.h
 *
 * IMPORTANT: MAKE SURE PCH FLAG AND FILE COMPILATION FLAG ARE THE SAME, ELSE
 *     YOU GET NO BENEFIT ON FASTER COMPILATION
 */

/* #include <bits/stdc++.h> */
#include <algorithm>
#include <bitset>
#include <cctype>
#include <chrono>
#include <climits>
#include <cmath>
#include <complex>
#include <cstring>
#include <functional>
#include <iomanip>
#include <iostream>
#include <iterator>
#include <map>
#include <numeric>
#include <queue>
#include <random>
#include <set>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
using namespace std;
using namespace __gnu_pbds;

/* helper functions */
void _print(long long t)          { cerr << t; }
void _print(int t)                { cerr << t; }
void _print(string t)             { cerr << t; }
void _print(char t)               { cerr << t; }
void _print(long double t)        { cerr << t; }
void _print(double t)             { cerr << t; }
void _print(unsigned long long t) { cerr << t; }

/* templates */
template <class T, class V> void _print(pair<T, V> p);
template <class T> void          _print(vector<T> v);
template <class T> void          _print(set<T> v);
template <class T> void          _print(multiset<T> v);
template <class T, class V> void _print(map<T, V> v);
template <class T> void          _print(stack<T> st);
template <class T> void          _print(queue<T> q);
template <class T> void          _print(deque<T> dq);
template <class T> void          _print(priority_queue<T> pq);
template <class T> void          _print(priority_queue<T, vector<T>, greater<T> > pq);
template <class T> void          _print(unordered_set<T> us);
template <class T, class V> void _print(unordered_map<T, V> um);
template <typename T> using ordered_set = tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;
template <typename T> struct ordered_multiset {
	ordered_set<pair<T, int> > vals;
	set<pair<T, int> > best; /* start at -1 */

	/* helper, find the lowest value that represents the element */
	int findbest(T val) {
		return (*best.upper_bound(make_pair(val - 1, 0))).second;
	}

	/* is element in set */
	bool contains(T val) {
		return vals.find(make_pair(val, -1)) != vals.end();
	}

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
		if (!contains(val)) return; /* not in */
		T loc = findbest(val);

		/* remove the element and its best */
		best.erase(make_pair(val, loc));
		vals.erase(make_pair(val, loc));
		if (loc != -1) best.insert(make_pair(val, loc + 1)); /* more elements in set, update best */
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
	int count(T k) { return vals.order_of_key({k, 0}) - vals.order_of_key({k - 1, 0}); }
	auto lower_bound(T k) { return vals.lower_bound(make_pair(k - 1, 0)); }
	auto upper_bound(T k) { return vals.upper_bound(make_pair(k, 0)); }
};

/* definitions */
template <class T, class V> void _print(pair<T, V> p) {
	cerr << "{";
	_print(p.first);
	cerr << ",";
	_print(p.second);
	cerr << "}";
}

template <class T> void _print(vector<T> v) {
	cerr << "[ ";
	for (T i : v) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}

template <class T> void _print(set<T> v) {
	cerr << "[ ";
	for (T i : v) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}

template <class T> void _print(multiset<T> v) {
	cerr << "[ ";
	for (T i : v) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}

template <class T, class V> void _print(map<T, V> v) {
	cerr << "[ ";
	for (auto i : v) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}

template <class T> void _print(stack<T> st) {
	vector<T> temp;
	while (!st.empty()) {
		temp.push_back(st.top());
		st.pop();
	}
	reverse(temp.begin(), temp.end());   // to print in original order
	_print(temp);
}

template <class T> void _print(queue<T> q) {
	vector<T> temp;
	while (!q.empty()) {
		temp.push_back(q.front());
		q.pop();
	}
	_print(temp);
}

template <class T> void _print(deque<T> dq) {
	cerr << "[ ";
	for (T i : dq) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}

template <class T> void _print(ordered_set<T> os) {
	cerr << "[ ";
	for (T i : os) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}

template <class T> void _print(ordered_multiset<T> oms) {
	cerr << "[ ";
	for (auto i : oms) {
		_print(i.first);
		cerr << " ";
	}
	cerr << "]";
}

template <class T> void _print(priority_queue<T> pq) {
	vector<T> temp;
	while (!pq.empty()) {
		temp.push_back(pq.top());
		pq.pop();
	}
	_print(temp);
}

template <class T> void _print(priority_queue<T, vector<T>, greater<T> > pq) {
	vector<T> temp;
	while (!pq.empty()) {
		temp.push_back(pq.top());
		pq.pop();
	}
	_print(temp);
}

template <class T> void _print(unordered_set<T> us) {
	cerr << "[ ";
	for (T i : us) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}

template <class T, class V> void _print(unordered_map<T, V> um) {
	cerr << "[ ";
	for (auto i : um) {
		_print(i);
		cerr << " ";
	}
	cerr << "]";
}
