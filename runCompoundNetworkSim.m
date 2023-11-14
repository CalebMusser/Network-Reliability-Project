

function result = runCompoundNetworkSim(K, p, N)

    simResults = ones(1, N); % Placeholder for the result of each simulation

    for i = 1:N
        txAttemptCount = 0; % Transmission count
        pktSuccessCount = 0; % Number of packets that have made it across

        while pktSuccessCount < K

            % Link 1 and 2 in parallel, Link 3 in series
            r = rand; % Generate random number to determine if packet is successful across the first link (r > p)
            r2 = rand; % Generate random number to determine if packet is successful across the second link (r2 > p)
            r3 = rand; % Generate random number to determine if packet is successful across the third link (r3 > p)
            txAttemptCount = txAttemptCount + 1; % Count 1st attempt

            % While packet transmissions are not successful across the parallel links and the third link (r < p && r2 < p) || r3 < p
            while (r < p && r2 < p) || r3 < p
                r = rand; % Transmit again, generate new success check value r
                r2 = rand; % Generate new success check value r2
                r3 = rand; % Generate new success check value r3
                txAttemptCount = txAttemptCount + 1; % Count additional attempt
            end

            % Increase success count after success (r > p || r2 > p) && r3 > p
            pktSuccessCount = pktSuccessCount + 1;
        end

        simResults(i) = txAttemptCount; % Record the total number of attempted transmissions before the entire application message (K successful packets) is transmitted
    end

    result = mean(simResults);
end
