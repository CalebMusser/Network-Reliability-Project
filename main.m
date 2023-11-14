
%% Define Functions

% Function for a single link simulation (inner loop)
singleLinkSim = @(K, p) singleLinkSimulation(K, p);

% Function for a single link simulation
runSingleLinkSim = @(K, p, N) mean(arrayfun(@(i) singleLinkSim(K, p), 1:N));

% Function for two series link simulation (inner loop)
twoSeriesLinkSim = @(K, p) twoSeriesLinkSimulation(K, p);

% Function for two series link simulation
runTwoSeriesLinkSim = @(K, p, N) mean(arrayfun(@(i) twoSeriesLinkSim(K, p), 1:N));

% Function for two parallel link simulation (inner loop)
twoParallelLinkSim = @(K, p) twoParallelLinkSimulation(K, p);

% Function for two parallel link simulation
runTwoParallelLinkSim = @(K, p, N) mean(arrayfun(@(i) twoParallelLinkSim(K, p), 1:N));

% Function for compound network simulation (inner loop)
compoundNetworkSim = @(K, p) compoundNetworkSimulation(K, p);

% Function for compound network simulation
runCompoundNetworkSim = @(K, p, N) mean(arrayfun(@(i) compoundNetworkSim(K, p), 1:N));

% Function for custom compound network simulation (inner loop)
customCompoundNetworkSim = @(K, p1, p2) customCompoundNetworkSimulation(K, p1, p2);

% Function for custom compound network simulation
runCustomCompoundNetworkSim = @(K, p1, p2, N) mean(arrayfun(@(i) customCompoundNetworkSim(K, p1, p2), 1:N));

% Task 1 - Simulate a Single Link Network

% Initializing Variables
n = 1000;
k_values = [1, 5, 15, 50, 100];
p_values = 0:0.01:0.99;
num_simulations = 100;

% Arrays to store simulation and calculated averages
simulationAverages = zeros(length(k_values), length(p_values), num_simulations);
calculatedAverages = zeros(length(k_values), length(p_values), num_simulations);

% Calculations and Simulations
for k_index = 1:length(k_values)
    k = k_values(k_index);
    
    for p_index = 1:length(p_values)
        realP = (p_values(p_index) - 1) / 100;
        
        for sim = 1:num_simulations
            simulationAverages(k_index, p_index, sim) = runSingleLinkSim(k, realP, n);
            calculatedAverages(k_index, p_index, sim) = k / (1 - realP);
        end
    end
end

% Graphs for a Single Link Network
for k_index = 1:length(k_values)
    figure;

    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O', 'Color', 'k');
        hold on;

    end
    semilogy(p_values, mean(calculatedAverages(k_index, :, :), 3), 'Color', 'b');
    title(['Single Link ', num2str(k_values(k_index)), ' Packets']);
    xlabel('Chance of Failure');
    ylabel('Average Number Of Transmissions');
    hold off;

end

% Additional graphs for all simulations
figure;

for k_index = 1:length(k_values)
    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O');
        hold on;

    end

end

for k_index = 1:length(k_values)
    semilogy(p_values, mean(calculatedAverages(k_index, :, :), 3));

end
title('Single Link All Simulations');
xlabel('Chance of Failure');
ylabel('Average Number Of Transmissions');
hold off;

% Task 2 - Simulate a Two Series Link Network

% Initializing Variables
n = 1000;
k_values = [1, 5, 15, 50, 100];
p_values = 0:0.01:0.99;
num_simulations = 100;

% Arrays to store simulation and calculated averages
simulationAverages = zeros(length(k_values), length(p_values), num_simulations);
calculatedAverages = zeros(length(k_values), length(p_values), num_simulations);

% Calculations and Simulations
for k_index = 1:length(k_values)
    k = k_values(k_index);
    
    for p_index = 1:length(p_values)
        realP = (p_values(p_index) - 1) / 100;
        
        for sim = 1:num_simulations
            simulationAverages(k_index, p_index, sim) = runTwoSeriesLinkSim(k, realP, n);
            calculatedAverages(k_index, p_index, sim) = k / ((1 - realP)^2);

        end
    end
end

% Graphs for Two Series Link Network
for k_index = 1:length(k_values)
    figure;

    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O', 'Color', 'k');
        hold on;

    end
    semilogy(p_values, mean(calculatedAverages(k_index, :, :), 3), 'Color', 'b');
    title(['Two Series Link ', num2str(k_values(k_index)), ' Packets']);
    xlabel('Chance of Failure');
    ylabel('Average Number Of Transmissions');
    hold off;

end

% Additional graphs for all simulations
figure;
for k_index = 1:length(k_values)

    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O');
        hold on;
    end
end

for k_index = 1:length(k_values)
    semilogy(p_values, mean(calculatedAverages(k_index, :, :), 3));
    
end

title('Two Series Link All Simulations');
xlabel('Chance of Failure');
ylabel('Average Number Of Transmissions');
hold off;

% Task 3 - Simulate a Two Parallel Link Network

% Initializing Variables
n = 1000;
k_values = [1, 5, 15, 50, 100];
p_values = 0:0.01:0.99;
num_simulations = 100;

% Arrays to store simulation averages
simulationAverages = zeros(length(k_values), length(p_values), num_simulations);

% Calculations and Simulations
for k_index = 1:length(k_values)
    k = k_values(k_index);
    
    for p_index = 1:length(p_values)
        realP = (p_values(p_index) - 1) / 100;
        
        for sim = 1:num_simulations
            simulationAverages(k_index, p_index, sim) = runTwoParallelLinkSim(k, realP, n);
        end
    end
end

% Graphs for Two Parallel Link Network
for k_index = 1:length(k_values)
    figure;
    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O', 'Color', 'k');
        hold on;
    end
    title(['Two Parallel Link ', num2str(k_values(k_index)), ' Packets']);
    xlabel('Chance of Failure');
    ylabel('Average Number Of Transmissions');
    hold off;
end

% Additional graphs for all simulations
figure;
for k_index = 1:length(k_values)
    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O');
        hold on;
    end
end
title('Two Parallel Link All Simulations');
xlabel('Chance of Failure');
ylabel('Average Number Of Transmissions');
hold off;

% Task 4 - Simulate a Compound Network

% Initializing Variables
n = 1000;
k_values = [1, 5, 15, 50, 100];
p_values = 0:0.01:0.99;
num_simulations = 100;

% Arrays to store simulation averages
simulationAverages = zeros(length(k_values), length(p_values), num_simulations);

% Calculations and Simulations
for k_index = 1:length(k_values)
    k = k_values(k_index);
    
    for p_index = 1:length(p_values)
        realP = (p_values(p_index) - 1) / 100;
        
        for sim = 1:num_simulations
            simulationAverages(k_index, p_index, sim) = runCompoundNetworkSim(k, realP, n);
        end
    end
end

% Graphs for Compound Network
for k_index = 1:length(k_values)
    figure;
    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O', 'Color', 'k');
        hold on;
    end
    title(['Compound Network ', num2str(k_values(k_index)), ' Packets']);
    xlabel('Chance of Failure');
    ylabel('Average Number Of Transmissions');
    hold off;
end

% Additional graphs for all simulations
figure;
for k_index = 1:length(k_values)
    for sim = 1:num_simulations
        semilogy(p_values, simulationAverages(k_index, :, sim), 'O');
        hold on;
    end
end
title('Compound Network All Simulations');
xlabel('Chance of Failure');
ylabel('Average Number Of Transmissions');
hold off;

%% Task 5 - Simulate a Custom Compound Network with Different Probabilities

% Initializing Variables
n = 1000;
k_values = [1, 5, 10];
p10 = 0.1;
p60 = 0.6;
num_simulations = 100;

% Arrays to store simulation averages
simulationAverages = zeros(length(k_values), num_simulations);

% Calculations and Simulations
for k_index = 1:length(k_values)
    k = k_values(k_index);
    
    for sim = 1:num_simulations
        simulationAverages(k_index, sim) = runCustomCompoundNetworkSim(k, p10, p60, n);
    end
end

% Graphs for Custom Compound Network
figure;
for k_index = 1:length(k_values)
    for sim = 1:num_simulations
        semilogy(0:0.01:0.99, simulationAverages(k_index, sim), 'O', 'Color', 'k');
        hold on;
    end
end
title('Custom Compound Network');
xlabel('Chance of Failure');
ylabel('Average Number Of Transmissions');
hold off;

