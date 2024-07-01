# Ride Page Rules

## General Guidelines
- **Start Time:** This is the start time of the ride. All control point times are calculated based on this start time.
- **Distance:** Total distance of the ride in kilometers.
- **Time Control Type:** Can be either BRM or Populaire. The type affects the speed calculation for control points.

## Control Points
- **Number of Control Points:** The total number of control points for the ride.
- **Control Point Distance:** The distance of each control point from the start in kilometers.
- **Control Point Close Time:** Calculated as the start time plus the time into the ride. This field is read-only, disabled, and automatically updated.
- **Total Time into Ride:** The time from the start time to the control point. This is calculated and displayed in the format of hours and minutes (e.g., 6:40). This field is also read-only, disabled, and automatically updated.

## Calculation Rules
- **Close Time Calculation:**
  - BRM: Minimum speed of 15 km/h.
  - Populaire: Minimum speed of 12.5 km/h.
  - Close time is calculated as the start time plus the time it takes to reach the control point at the minimum speed.
- **Total Time into Ride Calculation:**
  - Calculated as the time from the start time to the control point distance.
  - Displayed in the format of hours and minutes.

## Handling Changes
- **Recalculation Triggers:**
  - The `calculateControlTimes` function is called every time any field is edited.
  - Any change in the distance, time control type, number of control points, or start time triggers a recalculation of control point times.
- **Logging:**
  - A `console.log` statement is included in the recalculation function to log the inputs and results for debugging purposes.

## Exclusions
- **Open Time:**
  - Open time is not needed and should be excluded from the calculations and display.

## Example
- **Start Time:** 04:00 AM
- **Distance:** 150 km
- **Time Control Type:** BRM
- **Number of Control Points:** 2
- **Control Point 1 Distance:** 100 km
- **Control Point 1 Close Time:** 04:00 AM + 6:40 hours (calculated automatically, read-only, and disabled)
- **Total Time into Ride:** 6:40 hours (calculated automatically, read-only, and disabled)

This document serves as a quick reference for the rules and logic implemented on the ride page.