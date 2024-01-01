#ifndef OPERATORS_END_ANCHOR
#define OPERATORS_END_ANCHOR

#include <tuple>

#include <heuristics.hpp>
#include <nodes/basic_node.hpp>
#include <static_string.hpp>
#include <terminals/anchors/end.hpp>

#include "common.hpp"

namespace e_regex
{
    template<typename last_node>
    struct tree_builder_helper<last_node, std::tuple<pack_string<'$'>>>
    {
            // End anchor found

            using new_node
                = basic_node<terminals::anchors::end, std::tuple<>, 1, 1, policy::POSSESSIVE>;

            using tree = add_child_t<last_node, new_node>;
    };
}// namespace e_regex

#endif /* OPERATORS_END_ANCHOR */
