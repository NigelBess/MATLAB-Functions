function fixfig_ME105(fignum, alternate_pointlabel_size, specialfill)
    % Modified from original fixfig for use in ME 105 by M Aling, M Dai, N Bess
    % Version 4/18/2018 5:00 pm
    %
    % Note: Unlike original fixfig, this will MULTIPLY your line and marker sizes, so you can still control relative thicknesses
    % However, make sure not to call fixfig twice on the same figure, because everything will become huge
    %
    % THIS FUNCTION CAN BE RUN WITHOUT ANY ARGUMENTS:
    %   >> fixfig_ME105
    %   This will style the current figure (most-recently-produced, in most cases)
    %
    % ARGUMENT DESCRIPTION
    % fignum is the figure number to modify if you don't want the default (current figure)
    %   Literally where the window says 'figure n', this is n)
    %   Set fignum to -1 to use the default (current figure) if you just want to set alternate_pointlabel_size or specialfill
    % alternate_pointlabel_size will allow you to specify a different font size for text on the plot itself, to fit your needs
    %   Set alternate_pointlabel_size to -1 to take the standard size if you just want to set specialfill
    %   Set alternate_pointlabel_size to -2 to leave them unchanged (MATLAB default)
    % specialfill will fill markers ('o', '^', 'd', 's') with a lighter color if true. Otherwise (false or default) will fill with existing color.
    %
    % Original code:
    % M. A. Hopcroft
    %  mhopeng@gmail.com

    
    %% Setting our figure preferences

    % Lines
    default_linewidth = 0.5; % In MATLAB r2018a
    default_linewidth_becomes = 2; % Default-sized lines will become this size
    linewidth_multiplier = default_linewidth_becomes / default_linewidth;
    
    % Markers
    default_markersize = 6; % In MATLAB r2018a
    default_markersize_becomes = 8; % Default-sized markers will become this size
    markersize_multiplier = default_markersize_becomes / default_markersize;
    
    % Font name
    myfont = 'Arial';
    
    % Font sizes
    fontsize_title = 14;
    fontsize_axislabels = 14;
    %fontsize_axisticks = 12; % MATLAB doesn't look like it can do this separately
    fontsize_legend = 12;
    fontsize_on_plot = 11;

    
    %% Deal with input arguments

    if (nargin < 1 || fignum == -1)
        if verLessThan('matlab','R2014b')
            fignum = gcf;
        else
            figobj = gcf;
            fignum = figobj.Number;
        end
    end

    if (nargin >= 2 && alternate_pointlabel_size ~= -1)
        fontsize_on_plot = alternate_pointlabel_size;
    end
    
    if nargin < 3
        specialfill = false;
    end
    
    
    %% ~~ BEGIN USEFUL STUFF ~~

    %% Figure background (white)
    set(fignum,'color','w');

    % identify the axes in the figure
    if verLessThan('matlab','R2014b')
        a=get(fignum,'Children')';
    else
        ax = findobj(fignum,'Type','axes');
        % this is an ugly hack, but it works with the existing code
        for k = 1:length(ax)
            a(k) = ax(k);
        end
    end
    
    % Start a loop that goes over all axis objects in the figure (useful for subplots)
    k=0;
    for i=fliplr(a)
        k=k+1;
        
        % Find all the lines on this axis object
        dataline = findobj(i,'Type','line');

        % Cycle through the lines on this axis object
        for j = dataline'
            
            %% Lines
            set(j, 'LineWidth', linewidth_multiplier * get(j, 'LineWidth')); % Multiply the existing linewidth instead of setting absolute value
            if get(j, 'LineWidth') ~= default_linewidth_becomes
                %warning('fixfig_ME105: A resulting LineWidth is different than the standard value. This is either because you specified a thicker / thinner LineWidth initially (which might be intended behavior; this function just multiplies your existing LineWidth''s) or because you accidentally called fixfig_ME105 multiple times.');
            end
            
            %% Markers
            mkr = get(j,'Marker');
            if ~strcmp(mkr,'none') % If there are markers associated with this dataline

                % Set marker size
                mkrsz = get(j,'MarkerSize');
                set(j, 'MarkerSize', mkrsz * markersize_multiplier);
                if get(j, 'MarkerSize') ~= default_markersize_becomes
                    %warning('fixfig_ME105: A resulting MarkerSize is different than the standard value. This is either because you specified a smaller / larger MarkerSize initially (which might be intended behavior; this function just multiplies your existing MarkerSize''s) or because you accidentally called fixfig_ME105 multiple times.');
                end

                % Colorize marker faces
                c = get(j, 'Color');
                if (specialfill) % If you want fancy two-tone markers
                    c = 1.5 * c;
                    for k = 1:3
                        if c(k) > 1
                            c(k) = 1;
                        end
                    end
                end
                set(j, 'MarkerFaceColor', c);

            end
                
            
        end

        %% Font sizes
        
        % On-plot text (e.g.: labels for data points)
        if ((nargin >= 2 && alternate_pointlabel_size ~= -2) || nargin < 2) % If you don't want on-plot text messed with, don't do this
            datatext = findobj(i,'Type','text');
            for p = datatext'
                set(p,'FontSize',fontsize_on_plot,'FontName',myfont);
            end
        end
        
        % Set the default for any text I haven't thought of AND the legend and axis tick value labels
        set(i,'FontSize',fontsize_legend,'FontName',myfont);%'FontWeight','bold','FontName',myfont)

        % title
        set(get(i,'Title'),'FontSize',fontsize_title,'FontName',myfont)

        % x axis label
        set(get(i,'XLabel'),'FontSize',fontsize_axislabels,'FontName',myfont)

        % y axis label
        set(get(i,'YLabel'),'FontSize',fontsize_axislabels,'FontName',myfont)

        % z axis label
        set(get(i,'ZLabel'),'FontSize',fontsize_axislabels,'FontName',myfont)
        
        
        % Make background fill transparent so that legends, text, etc can be seen
        if ~strcmpi(get(i,'Tag'),'legend') % but keep legend opaque
            set(i,'Color','none')
        end
    end

end