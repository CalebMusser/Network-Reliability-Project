
function result = runSingleLinkSim(K, p, N)
    % Initialize an array to store the result of each simulation
    simResults = ones(1, N);

    % Perform N simulations
    for i = 1:N
        txAttemptCount = 0;    % Initialize transmission count
        pktSuccessCount = 0;   % Initialize successful packet count

        % Continue until K packets are successfully transmitted
        while pktSuccessCount < K
            r = rand;   % Generate a random number to determine packet success (r > p)
            txAttemptCount = txAttemptCount + 1; % Count the first attempt

            % Keep attempting until packet transmission is successful (r < p)
            while r < p
                r = rand;   % Generate a new random value for the success check
                txAttemptCount = txAttemptCount + 1; % Count additional attempts
            end

            pktSuccessCount = pktSuccessCount + 1; % Increase success count after successful transmission (r > p)
        end

        simResults(i) = txAttemptCount; % Record the total number of attempted transmissions for the simulation
    end

    % Calculate the mean of all simulation results
    result = mean(simResults);
end
