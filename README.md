# FSM Timer Demo

A four-state FSM-based timer with an asynchronous override input that forces an immediate transition to a designated state.

## Description

`timer_demo` is a timed finite state machine that progresses through four states (`S0` → `S1` → `S2` → back to `S0`), each holding for a specific number of clock ticks, tracked internally by a counter (`t`). An override input (`ovr`) can interrupt the normal cycle at any time and force the FSM directly into state `S3`, regardless of the current state or timer count.

## Ports

| Port | Direction | Width | Description |
|---|---|---|---|
| `clk` | input | 1 | Clock signal |
| `rst` | input | 1 | Active-low asynchronous reset |
| `ovr` | input | 1 | Override — forces immediate transition to state S3 |
| `out` | output reg | 1 | High during states S1 and S3 |
| `state` | output reg | 4 | Current FSM state |
| `timer` | output | 4 | Current internal timer/tick count |

## FSM Design

**States:**
- `S0` (`4'b0000`) — waits until `t == 2`, then moves to S1
- `S1` (`4'b0001`) — waits until `t == 3`, then moves to S2
- `S2` (`4'b0010`) — waits until `t == 2`, then moves to S0
- `S3` (`4'b0011`) — override state, always returns to S0 next cycle

**Override behavior:** Regardless of current state or timer value, asserting `ovr` forces the next state to `S3` immediately (asynchronous-priority style, handled combinationally in the input block).

**Output behavior (Moore):**
| State | out |
|---|---|
| S0 | 0 |
| S1 | 1 |
| S2 | 0 |
| S3 | 1 |

## Structure

Follows the standard **three-block FSM style**, plus an internal tick counter:
1. **Input/next-state block** — combinational, includes override priority logic
2. **Sequential block** — updates state and tick counter `t` on `posedge clk` / `negedge rst`
3. **Output block** — Moore-style output based on current state only

The tick counter `t` resets to 0 whenever the state changes (or on reset) and increments each clock cycle within a state until its target count is reached, giving each state a distinct configurable "duration" in clock ticks.

## Authors

Caberoy, Adrian Miko A. · Vigilar, Franz Louis G. — 10 May 2026
