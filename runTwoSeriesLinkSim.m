
%% Function runTwoSeriesLinkSim()
% Parameters
%  K - the number of packets in the application message
%  p - the probability of failure 
%  N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations

function result = runTwoSeriesLinkSim(K,p,N)

    simResults = ones(1,N); % a place to store the result of each simulation

    for i=1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have made it across

        while pktSuccessCount < K
            r = rand; % generate random number to determine if packet is successful across the first link (r > p)
            r2 = rand; % generate random number to determine if packet is successful across the second link (r2 > p)
            txAttemptCount = txAttemptCount + 1; % count 1st attempt
            % while packet transmissions is not successful on both links (r < p) || (r2 < p)
            while r < p || r2<p
                r = rand; % transmit again, generate new success check value r
                r2 = rand; % generate new success check value r2
                txAttemptCount = txAttemptCount + 1; % count additional attempt                        
            end
            pktSuccessCount = pktSuccessCount + 1; % increase success count after success (r > p) && (r2 > p)
        end

        simResults(i) = txAttemptCount; % record total number of attempted transmissions before entire application message (K successful packets) transmitted
    end

    result = mean(simResults);
end