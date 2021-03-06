function mv_plot(varargin)
%% Plotting function for mean - variance frame work
%
% any line plots to be included in the legend must be first arguments into this function
%
% format:
%	first argument must be a title for the plot
%	remaining arguments are cell arrays for each plot overlay
%
%	{ 'type', rsk, ret, label, style, line}, ...
%
%	'type'	'line'		line plot
%			'scatter'	scatter plot
%	rsk					risk proxies
%	ret					return proxies
%	label				labels for each series
%	style				style for plot (string to specify color, also linestyle if line plot)
%						default is 'b' for line plots and 'g' for scatter plots
%	line				if a line plot, the width of the line, default is 2
%

plottitle = varargin{1};
plotlegend = [];

for i = 2:nargin
	plotinfo = varargin{i};
	
	plottype = plotinfo{1};
	plotrsk = plotinfo{2};
	plotret = plotinfo{3};
	if numel(plotinfo) > 3
		plotlabel = plotinfo{4};
	else
		plotlabel = [];
	end
	if numel(plotinfo) > 4
		plotstyle = plotinfo{5};
		if isempty(plotstyle)
			plotstyle = 'b';
		end
	else
		if strcmpi(plottype,'line')
			plotstyle = 'b';
		else
			plotstyle = 'g';
		end
	end
	if numel(plotinfo) > 5
		plotline = plotinfo{6};
		if isempty(plotline)
			plotline = 2;
		end
	else
		if strcmpi(plottype,'line')
			plotline = 2;
		else
			plotline = [];
		end
	end
	
	% line plot
	if strcmpi(plottype,'line')
		for k = 1:size(plotrsk,2)
			plot(plotrsk(:,k), plotret(:,k), plotstyle, 'LineWidth', plotline);
			if i == 2 && k == 1
				hold on
			end
			if ~isempty(plotlabel) && ~isempty(plotlabel{k})
				plotlegend = [ plotlegend, {plotlabel{k}} ];
			end
		end
		
	% scatter plot
	else
		if any(plotstyle == '.')
			scatter(plotrsk, plotret, plotstyle);
		else
			scatter(plotrsk, plotret, plotstyle, 'Filled');
		end			
		if i == 2
			hold on
		end
		if ~isempty(plotlabel)
			for k = 1:numel(plotrsk)
				if ~isempty(plotlabel{k})
					text(plotrsk(k) + 0.00005, plotret(k), plotlabel{k}, 'FontSize', 8);
				end
			end
		end
	end
end

if ~isempty(plotlegend)
	legend(plotlegend,'Location','SouthEast');
end

title(['\bf' plottitle ]);
xlabel('Standard Deviation of Returns (Risk)');
ylabel('Mean of Returns (Percent)');
grid on

hold off
