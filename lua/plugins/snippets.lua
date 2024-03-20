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
#include <bits/stdc++.h>
using namespace std;

#define int long long
#define pi pair<int, int>
#define rep(i, n) for(int i = 0; i < n; i++)
#define all(x) x.begin(), x.end()
#define endl "\n"

template<class T> bool ckmin(T& a, const T& b) { return b < a ? a = b, 1 : 0; }
template<class T> bool ckmax(T& a, const T& b) { return a < b ? a = b, 1 : 0; }

void solve() {
  @!
}

signed main() {
  ios_base::sync_with_stdio(false);
  cin.tie(NULL);
  int t = 1;
  cin >> t;
  while(t--) solve();
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
          "mint",
          fmt(
            [[
template<int MOD> struct mint {
  int v; 
  explicit operator int() const { return v; } 
  mint(int _v = 0) : v((_v % MOD + MOD) % MOD) {}
  mint& operator+=(mint o) { if ((v += o.v) >= MOD) v -= MOD; return *this; }
  mint& operator-=(mint o) { if ((v -= o.v) < 0) v += MOD; return *this; }
  mint& operator*=(mint o) { v = v * o.v % MOD; return *this; }
  mint& operator++() { return *this += 1; }
  mint& operator--() { return *this -= 1; }
  mint operator-() const { return mint(-v); }
  friend mint pow(mint a, int p) { assert(p >= 0); return p == 0 ? 1: pow(a * a, p / 2) * (p & 1 ? a : 1); }
  friend mint inv(mint a) { assert(a.v != 0); return pow(a , MOD - 2); }
  friend mint operator+(mint a, mint b) { return a += b; }
  friend mint operator-(mint a, mint b) { return a -= b; }
  friend mint operator*(mint a, mint b) { return a *= b; }
  friend ostream& operator<<(ostream &out, mint &a) { return out << a.v; }
  friend istream& operator>>(istream &in, mint &a) { in >> a.v; a.v = (a.v % MOD + MOD) % MOD; return in; }
};
const int mod = 1e9 + 7;
using Z = mint<mod>;
@`
          ]],
            {
              i(1)
            },
            {
              delimiters = "@`"
            }
          )
        ),

        s(
          "cp2",
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

#include <ext/pb_ds/assoc_container.hpp>
using namespace __gnu_pbds;

template<typename T> using ordered_set = 
tree<T, null_type, less<T>, rb_tree_tag, tree_order_statistics_node_update>;

#define int long long
#define pi pair<int, int>
template<class T> using v = vector<T>;
#define vi v<int>
#define vs v<string>
#define vb v<bool>
#define vp v<pi>
#define pb push_back
#define rep(i, n) for(int i = 0; i < n; i++)
#define all(x) x.begin(), x.end()
#define endl "\n"
#define fi first
#define se second

template<class T> bool ckmin(T& a, const T& b) { return b < a ? a = b, 1 : 0; }
template<class T> bool ckmax(T& a, const T& b) { return a < b ? a = b, 1 : 0; }

template<class T> using pq = priority_queue<T>;
template<class T> using pqg = priority_queue<T, vector<T>, greater<T>>;

const int dx[]{1, 0, -1, 0};
const int dy[]{0, -1, 0, 1};
const int inf = 1e18;

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
  int t = 1;
  cin >> t;
  while(t--) solve();
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
          "usaco",
          fmt(
            [[
string name = "";
freopen((name + ".in").c_str(), "r", stdin);
freopen((name + ".out").c_str(), "w", stdout);@!
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


      require("luasnip.loaders.from_vscode").load({ include = { "python", "html", "typescript", "javascript" } })

      require('luasnip').filetype_extend("typescript", { "html" })
      require('luasnip').filetype_extend("typescriptreact", { "html" })
    end
  },
}
