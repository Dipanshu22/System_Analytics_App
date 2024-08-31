#define _WIN32_WINNT 0x0501  // Target Windows XP or later

#include <windows.h>
#include <iostream>
#include <fstream>

// Function to calculate CPU usage based on system times
void GetCPUUsage(double& cpuUsage) {
    FILETIME idleTime, kernelTime, userTime;

    // Get system times for idle, kernel, and user modes
    if (GetSystemTimes(&idleTime, &kernelTime, &userTime) == 0) {
        std::cerr << "Failed to get system times." << std::endl;
        return;
    }

    // Static variables to store previous system times
    static bool firstRun = true;
    static ULARGE_INTEGER prevIdle, prevKernel, prevUser;

    // Current system times
    ULARGE_INTEGER currIdle, currKernel, currUser;

    currIdle.LowPart = idleTime.dwLowDateTime;
    currIdle.HighPart = idleTime.dwHighDateTime;
    currKernel.LowPart = kernelTime.dwLowDateTime;
    currKernel.HighPart = kernelTime.dwHighDateTime;
    currUser.LowPart = userTime.dwLowDateTime;
    currUser.HighPart = userTime.dwHighDateTime;

    // Skip the first run to initialize previous times
    if (firstRun) {
        prevIdle = currIdle;
        prevKernel = currKernel;
        prevUser = currUser;
        firstRun = false;
        return;
    }

    // Calculate time deltas (differences between current and previous times)
    ULONGLONG idleDelta = currIdle.QuadPart - prevIdle.QuadPart;
    ULONGLONG kernelDelta = currKernel.QuadPart - prevKernel.QuadPart;
    ULONGLONG userDelta = currUser.QuadPart - prevUser.QuadPart;

    // The total time delta is the sum of idle, kernel, and user deltas
    ULONGLONG totalDelta = idleDelta + kernelDelta + userDelta;

    // Debugging: Print intermediate values
    std::cout << "idleDelta: " << idleDelta << ", kernelDelta: " << kernelDelta << ", userDelta: " << userDelta << std::endl;
    std::cout << "totalDelta: " << totalDelta << std::endl;

    // Calculate CPU usage as a percentage
    if (totalDelta > 0) {
        cpuUsage = ((double)(kernelDelta + userDelta) / totalDelta) * 100.0;
        // Clamp CPU usage between 0 and 100%
        if (cpuUsage < 0.0) cpuUsage = 0.0;
        if (cpuUsage > 100.0) cpuUsage = 100.0;
    } else {
        cpuUsage = 0.0; // If no time delta, set CPU usage to 0%
    }

    // Update previous times with current times for the next iteration
    prevIdle = currIdle;
    prevKernel = currKernel;
    prevUser = currUser;
}

// Function to calculate RAM usage as a percentage of total physical memory
void GetRAMUsage(double& ramUsage) {
    MEMORYSTATUSEX statex;
    statex.dwLength = sizeof(statex);

    // Get the memory status of the system
    GlobalMemoryStatusEx(&statex);

    // Calculate RAM usage as a percentage
    ramUsage = (statex.ullTotalPhys - statex.ullAvailPhys) / (double)statex.ullTotalPhys * 100.0;
}

int main() {
    // Continuously monitor and log CPU and RAM usage
    while (true) {
        double cpuUsage = 0.0;
        double ramUsage = 0.0;

        // Get current CPU and RAM usage
        GetCPUUsage(cpuUsage);
        GetRAMUsage(ramUsage);

        // Write the CPU and RAM usage data to a text file
        std::ofstream out("cpu_ram_data.txt");
        if (out.is_open()) {
            out << "CPU: " << cpuUsage << std::endl;
            out << "RAM: " << ramUsage << std::endl;
            out.close();
        } else {
            std::cerr << "Failed to open file for writing." << std::endl;
        }

        // Sleep for 5 seconds before the next iteration
        Sleep(5000);
    }

    return 0;
}
