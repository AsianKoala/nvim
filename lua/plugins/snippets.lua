return {
  {
    "L3MON4D3/LuaSnip",
    -- commit = "9bff06b570df29434a88f9c6a9cea3b21ca17208",
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    opts = function ()
      local types = require("luasnip.util.types")

      return {
        history = true,
        -- Update more often, :h events for more info.
        update_events = "TextChanged,TextChangedI",
        -- Snippets aren't automatically removed if their text is deleted.
        -- `delete_check_events` determines on which events (:h events) a check for
        -- deleted snippets is performed.
        -- This can be especially useful when `history` is enabled.
        delete_check_events = "TextChanged",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "choiceNode", "Comment" } },
            },
          },
        },
        -- treesitter-hl has 100, use something higher (default is 200).
        ext_base_prio = 300,
        -- minimal increase in priority.
        ext_prio_increase = 1,
        enable_autosnippets = true,
        -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
        -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
        store_selection_keys = "<Tab>",
        -- luasnip uses this function to get the currently active filetype. This
        -- is the (rather uninteresting) default, but it's possible to use
        -- eg. treesitter for getting the current filetype by setting ft_func to
        -- require("luasnip.extras.filetype_functions").from_cursor (requires
        -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
        -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
        ft_func = function()
          return vim.split(vim.bo.filetype, ".", true)
        end,
        -- load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft({
        --   markdown = {"lua", "json"},
        --   html = { "all" },
        -- })
      }
    end,
    init = function ()
      local ls = require("luasnip")


      local s = ls.snippet
      local sn = ls.snippet_node
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local r = ls.restore_node
      local l = require("luasnip.extras").lambda
      local rep = require("luasnip.extras").rep
      local p = require("luasnip.extras").partial
      local m = require("luasnip.extras").match
      local n = require("luasnip.extras").nonempty
      local dl = require("luasnip.extras").dynamic_lambda
      local fmt = require("luasnip.extras.fmt").fmt
      local fmta = require("luasnip.extras.fmt").fmta
      local types = require("luasnip.util.types")
      local conds = require("luasnip.extras.expand_conditions")


      -- 'recursive' dynamic snippet. Expands to some text followed by itself.
      local rec_ls
      rec_ls = function()
        return sn(
          nil,
          c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(""),
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
          })
        )
      end

      -- complicated function for dynamicNode.
      local function jdocsnip(args, _, old_state)
        -- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
        -- Using a restoreNode instead is much easier.
        -- View this only as an example on how old_state functions.
        local nodes = {
          t({ "/**", " * " }),
          i(1, "A short Description"),
          t({ "", "" }),
        }

        -- These will be merged with the snippet; that way, should the snippet be updated,
        -- some user input eg. text can be referred to in the new snippet.
        local param_nodes = {}

        if old_state then
          nodes[2] = i(1, old_state.descr:get_text())
        end
        param_nodes.descr = nodes[2]

        -- At least one param.
        if string.find(args[2][1], ", ") then
          vim.list_extend(nodes, { t({ " * ", "" }) })
        end

        local insert = 2
        for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
          -- Get actual name parameter.
          arg = vim.split(arg, " ", true)[2]
          if arg then
            local inode
            -- if there was some text in this parameter, use it as static_text for this new snippet.
            if old_state and old_state[arg] then
              inode = i(insert, old_state["arg" .. arg]:get_text())
            else
              inode = i(insert)
            end
            vim.list_extend(
              nodes,
              { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
            )
            param_nodes["arg" .. arg] = inode

            insert = insert + 1
          end
        end

        if args[1][1] ~= "void" then
          local inode
          if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
          else
            inode = i(insert)
          end

          vim.list_extend(
            nodes,
            { t({ " * ", " * @return " }), inode, t({ "", "" }) }
          )
          param_nodes.ret = inode
          insert = insert + 1
        end

        if vim.tbl_count(args[3]) ~= 1 then
          local exc = string.gsub(args[3][2], " throws ", "")
          local ins
          if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
          else
            ins = i(insert)
          end
          vim.list_extend(
            nodes,
            { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
          )
          param_nodes.ex = ins
          insert = insert + 1
        end

        vim.list_extend(nodes, { t({ " */" }) })

        local snip = sn(nil, nodes)
        -- Error on attempting overwrite.
        snip.old_state = param_nodes
        return snip
      end

      ls.add_snippets("java", {
        -- Very long example for a java class.
        s("fn", {
          d(6, jdocsnip, { 2, 4, 5 }),
          t({ "", "" }),
          c(1, {
            t("public "),
            t("private "),
          }),
          c(2, {
            t("void"),
            t("String"),
            t("char"),
            t("int"),
            t("double"),
            t("boolean"),
            i(nil, ""),
          }),
          t(" "),
          i(3, "myFunc"),
          t("("),
          i(4),
          t(")"),
          c(5, {
            t(""),
            sn(nil, {
              t({ "", " throws " }),
              i(1),
            }),
          }),
          t({ " {", "\t" }),
          i(0),
          t({ "", "}" }),
        }),
      }, {
        key = "java",
      })

      ls.add_snippets("tex", {
        -- rec_ls is self-referencing. That makes this snippet 'infinite' eg. have as many
        -- \item as necessary by utilizing a choiceNode.
        s("ls", {
          t({ "\\begin{itemize}", "\t\\item " }),
          i(1),
          d(2, rec_ls, {}),
          t({ "", "\\end{itemize}" }),
        }),
        
        s("ff", {
          t("\\frac{"), i(1), t("}{"), i(2), t("}"),
        }),

        s("beg", {
          t("\\begin{"), i(1, "env"), t({"}", "\t\\item "}),
          i(2),
          t({"", "\\end{"}), rep(1), t("}")
        }),

        s("bx", {
          t({
            "\\begin{center}",
            "\t\\fbox{\\begin{varwidth}{\\dimexpr\\textwidth-2\\fboxsep-2\\fboxrule\\relax}",
            "\t\t\\begin{equation*}",
            "\t\t\t"
          }),
          i(1),
          t({
            "",
            "\t\t\\end{equation*}",
            "\t\\end{varwidth}}",
            "\\end{center}"
          })
        }),

        s("eq", {
          t({"\\begin{equation*}", "\t"}),
          i(1),
          t({"", "\\end{equation*}"})
        }),

        s("mt", {
          t("$ "), i(1), t(" $")
        }),

        s("pd", {
          t("\\frac{\\partial "), i(1), t("}{\\partial "), i(2), t("}")
        }),

        s("ve", {
          t("\\langle "), i(1), t(","), i(2), t(" \\rangle")
        }),

        s("vc", {
          t("\\bm{\\vec{"), i(1), t("}}")
        })
      }, {
        key = "tex",
      })

      ls.add_snippets("cpp", {
        s(
          "cp",
          fmt(
            [[
// ⣿⡟⠙⠛⠋⠩⠭⣉⡛⢛⠫⠭⠄⠒⠄⠄⠄⠈⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⡇⠄⠄⠄⠄⣠⠖⠋⣀⡤⠄⠒⠄⠄⠄⠄⠄⠄⠄⠄⠄⣈⡭⠭⠄⠄⠄⠉⠙
// ⣿⡇⠄⠄⢀⣞⣡⠴⠚⠁⠄⠄⢀⠠⠄⠄⠄⠄⠄⠄⠄⠉⠄⠄⠄⠄⠄⠄⠄⠄
// ⣿⡇⠄⡴⠁⡜⣵⢗⢀⠄⢠⡔⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
// ⣿⡇⡜⠄⡜⠄⠄⠄⠉⣠⠋⠠⠄⢀⡄⠄⠄⣠⣆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸
// ⣿⠸⠄⡼⠄⠄⠄⠄⢰⠁⠄⠄⠄⠈⣀⣠⣬⣭⣛⠄⠁⠄⡄⠄⠄⠄⠄⠄⢀⣿
// ⣏⠄⢀⠁⠄⠄⠄⠄⠇⢀⣠⣴⣶⣿⣿⣿⣿⣿⣿⡇⠄⠄⡇⠄⠄⠄⠄⢀⣾⣿
// ⣿⣸⠈⠄⠄⠰⠾⠴⢾⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⣾⢀⠁⠄⠄⠄⢠⢸⣿⣿
// ⣿⣿⣆⠄⠆⠄⣦⣶⣦⣌⣿⣿⣿⣿⣷⣋⣀⣈⠙⠛⡛⠌⠄⠄⠄⠄⢸⢸⣿⣿
// ⣿⣿⣿⠄⠄⠄⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠈⠄⠄⠄⠄⠄⠈⢸⣿⣿
// ⣿⣿⣿⠄⠄⠄⠘⣿⣿⣿⡆⢀⣈⣉⢉⣿⣿⣯⣄⡄⠄⠄⠄⠄⠄⠄⠄⠈⣿⣿
// ⣿⣿⡟⡜⠄⠄⠄⠄⠙⠿⣿⣧⣽⣍⣾⣿⠿⠛⠁⠄⠄⠄⠄⠄⠄⠄⠄⠃⢿⣿
// ⣿⡿⠰⠄⠄⠄⠄⠄⠄⠄⠄⠈⠉⠩⠔⠒⠉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠐⠘⣿
// ⣿⠃⠃⠄⠄⠄⠄⠄⠄⣀⢀⠄⠄⡀⡀⢀⣤⣴⣤⣤⣀⣀⠄⠄⠄⠄⠄⠄⠁⢹

#include <bits/stdc++.h>
using namespace std;

#define int long long
#define pi pair<int, int>
#define vt vector
#define vi vt<int>
#define vs vt<string>
#define vb vt<bool>
#define rep(i, n) for(int i = 0; i < n; i++)
#define all(x) x.begin(), x.end()
#define f first
#define s second
#define pb push_back

template<class T> bool ckmin(T& a, const T& b) { return b < a ? a = b, 1 : 0; }
template<class T> bool ckmax(T& a, const T& b) { return a < b ? a = b, 1 : 0; }

template<class T> using pq = priority_queue<T>;
template<class T> using pqg = priority_queue<T, vector<T>, greater<T>>;

template<class T, class... Args>
auto create(size_t n, Args&&... args) {
	if constexpr(sizeof...(args) == 1)
		return vector<T>(n, args...);
	else
		return vector(n, create<T>(args...));
}

void setIO(string name = "") {
	cin.tie(0)->sync_with_stdio(0);
	if (name.size()) {
		freopen((name + ".in").c_str(), "r", stdin);
		freopen((name + ".out").c_str(), "w", stdout);
  }
}

void solve() {
  @!
}

signed main() {
  setIO("");
  int t; cin >> t;
  while(t--) {
    solve();
  }
}
          ]],
            {
              i(1)
            },
            {
              delimiters = "@!"
            }
          )
        ),
        s(
          "cpfact",
          fmt([[
vpi factorize(int n) {
  vpi res;
  for(int i = 2; i * i <= n; i++) {
    if(n % i == 0) {
      int cnt = 0;
      while(n % i == 0) {
        n /= i;
        cnt++;
      }
      res.push_back({i, cnt});
    }
  }
  if(n > 1) {
    res.push_back({n, 1});
  }
  return res;
}
@!
          ]],
            {
              i(1)
            },
            {
              delimiters = "@!"
            }
          )
        ),
        s(
          "cpbinpow",
          fmt([[
ll binpow(ll a, ll b) {
  ll res = 1;
  while(b > 0) {
    if(b & 1) {
      res *= a;
    }
    a *= a;
    b >>= 1;
  }
  return res;
}
@!
          ]],
            {
              i(1)
            },
            {
              delimiters = "@!"
            }
          )
        ),
        s(
          "cpsegtree",
          fmt([[
template <class T> class MinSegmentTree {
  private:
	const T DEFAULT = std::numeric_limits<T>().max();
	vector<T> segtree;
	int len;

  public:
    MinSegmentTree(int len) : len(len), segtree(len * 2, DEFAULT) {}

	void set(int ind, T val) {
		ind += len;
		segtree[ind] = val;
		for (; ind > 1; ind /= 2) {
			segtree[ind / 2] = std::min(segtree[ind], segtree[ind ^ 1]);

		}
	}

	T range_min(int start, int end) {
		T min = DEFAULT;
		for (start += len, end += len; start < end; start /= 2, end /= 2) {
			if (start % 2 == 1) { min = std::min(min, segtree[start++]); }
			if (end % 2 == 1) { min = std::min(min, segtree[--end]); }
		}
		return min;
	}
};
@!
          ]],
            {
              i(1)
            },
            {
              delimiters = "@!"
            }
          )
        ),
        s(
          "cpdsu",
          fmt([[
struct DSU {
	vector<int> e;
	DSU(int N) { e = vector<int>(N, -1); }

	// get representive component (uses path compression)
	int get(int x) { return e[x] < 0 ? x : e[x] = get(e[x]); }

	bool same_set(int a, int b) { return get(a) == get(b); }

	int size(int x) { return -e[get(x)]; }

	bool unite(int x, int y) {  // union by size
		x = get(x), y = get(y);
		if (x == y) return false;
		if (e[x] > e[y]) swap(x, y);
		e[x] += e[y];
		e[y] = x;
		return true;
	}
};
@!
          ]],
            {
              i(1)
            },
            {
              delimiters = "@!"
            }
          )
        ),
        s(
          "cppbds",
          fmt([[
#include <ext/pb_ds/assoc_container.hpp>
using namespace __gnu_pbds;

template<typename T> using ordered_set = tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;
@!
          ]],
            {
              i(1)
            },
            {
              delimiters = "@!"
            }
          )
        ),

      }, {
          key = "cpp"
      }
    )



      -- set type to "autosnippets" for adding autotriggered snippets.
      -- ls.add_snippets("all", {
      -- 	s("autotrigger", {
      -- 		t("autosnippet"),
      -- 	}),
      -- }, {
      -- 	type = "autosnippets",
      -- 	key = "all_auto",
      -- })

      -- Beside defining your own snippets you can also load snippets from "vscode-like" packages
      -- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.

      require("luasnip.loaders.from_vscode").load({ include = { "python", "html", "typescript", "javascript" } }) -- Load only python snippets


      -- The directories will have to be structured like eg. <https://github.com/rafamadriz/friendly-snippets> (include
      -- a similar `package.json`)
      -- require("luasnip.loaders.from_vscode").load({ paths = { "./my-snippets" } }) -- Load snippets from my-snippets folder
      --
      -- -- You can also use lazy loading so snippets are loaded on-demand, not all at once (may interfere with lazy-loading luasnip itself).
      -- require("luasnip.loaders.from_vscode").lazy_load() -- You can pass { paths = "./my-snippets/"} as well
      --
      -- -- You can also use snippets in snipmate format, for example <https://github.com/honza/vim-snippets>.
      -- -- The usage is similar to vscode.
      --
      -- -- One peculiarity of honza/vim-snippets is that the file containing global
      -- -- snippets is _.snippets, so we need to tell luasnip that the filetype "_"
      -- -- contains global snippets:
      require('luasnip').filetype_extend("typescript", { "html" })
      require('luasnip').filetype_extend("typescriptreact", { "html" })

      --
      -- require("luasnip.loaders.from_snipmate").load({ include = { "c" } }) -- Load only snippets for c.
      --
      -- -- Load snippets from my-snippets folder
      -- -- The "." refers to the directory where of your `$MYVIMRC` (you can print it
      -- -- out with `:lua print(vim.env.MYVIMRC)`.
      -- -- NOTE: It's not always set! It isn't set for example if you call neovim with
      -- -- the `-u` argument like this: `nvim -u yeet.txt`.
      -- require("luasnip.loaders.from_snipmate").load({ path = { "./my-snippets" } })
      -- -- If path is not specified, luasnip will look for the `snippets` directory in rtp (for custom-snippet probably
      -- -- `~/.config/nvim/snippets`).
      --
      -- require("luasnip.loaders.from_snipmate").lazy_load() -- Lazy loading
      --
      -- -- see DOC.md/LUA SNIPPETS LOADER for some details.
      -- require("luasnip.loaders.from_lua").load({ include = { "c" } })
      -- require("luasnip.loaders.from_lua").lazy_load({ include = { "all", "cpp" } })
      -- TODO
    end
  },
}
