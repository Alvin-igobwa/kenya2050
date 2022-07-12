import anvil.tables as tables
import anvil.tables.query as q
from anvil.tables import app_tables
import anvil.server
from anvil import Button, Label, Plot, get_open_form
# adding open_form helps in the setting of the height
from ...Model import init_vals
from ...Plots import PLOTS_REGISTRY
from ._anvil_designer import FiguresPanelTemplate


class FiguresPanel(FiguresPanelTemplate):
    def __init__(self, **properties):
        # Set Form properties and Data Bindings.
        self.init_components(**properties)

        # Any code you write here will run when the form opens.
        self.build_tabs()

    def build_tabs(self):
        layout = init_vals["layout"]

        tabs = [
            self._add_button(self.tabs, tab)
            for tab in layout.keys()
            if tab.lower() not in ("warnings", "key indicators")
        ]
        sub_tab = self.build_sub_tabs(tabs[0])
        self.selected_tab = tabs[0], sub_tab

    def build_sub_tabs(self, tab):
        self.sub_tabs.clear()
        layout = init_vals["layout"]
        sub_tabs = [
            self._add_button(self.sub_tabs, sub_tab, sub_tab=True)
            for sub_tab in layout[tab.tag]
        ]
        return sub_tabs[0]

    def _add_button(self, element, name, sub_tab=False):
        button = Button(text=name)
        button.role = "tab-button"
        button.tag = name
        if not sub_tab:
            button.foreground = "theme:White"
        else:
            button.foreground = "theme:Primary 700"
        button.set_event_handler("click", self.tab_click)
        element.add_component(button)
        return button

    def calculate(self, inputs, start_year, end_year, expert_mode=False):
        """Run the model based on new inputs and build the graphs and warnings.

        Args:
        inputs (list): A list of all the ambition lever values.
        start_year (list): A list of the start year for each ambition lever.
        end_year (list): A list of the end year for each ambition lever.
        expert_mode (bool, optional): Flag to run in expert mode. Defaults to False.
        """
        self.model_solution = anvil.server.call(
            "calculate", inputs, start_year, end_year, expert_mode
        )
        self.build_graphs()
        self.build_warnings()

    def build_warnings(self,**event_args):
        self.warnings_panel.clear()
        warnings = init_vals["layout"]["Warnings"]["Not required"]

        for key in warnings:
            name, output, plot_type, _ = warnings[key]
            data = self.model_solution[output]
            active = data[0][1]
            tooltip = data[1][1]

            label = Label()
            if output == 'output_warning_l4chosen':
                if active:
                    label.icon = "fa:dice-four"
                    label.foreground = "rgb(204,0,0)"
                else:
                    label.icon = 'fa:dice-four'
                    label.foreground = "rgb(0,147,69)"
            if output == 'output_warning_exceedl4_rate':
                if active:
                    label.icon = "fa:rocket"
                    label.foreground = "rgb(204,0,0)"
                else:
                    label.icon = 'fa:rocket'
                    label.foreground = "rgb(0,147,69)"
            if output == 'output_warning_bio_imports':
                if active:
                    label.icon = "fa:seedling"
                    label.foreground = "rgb(204,0,0)"
                else:
                    label.icon = 'fa:seedling'
                    label.foreground = "rgb(0,147,69)"
            if output == 'output_warning_land':
                if active:
                    label.icon = "fa:tree"
                    label.foreground = "rgb(204,0,0)"
                else:
                    label.icon = 'fa:tree'
                    label.foreground = "rgb(0,147,69)"
            if output == 'output_warning_elec_peak':
                if active:
                    label.icon = "fa:bolt"
                    label.foreground = "rgb(204,0,0)"
                else:
                    label.icon = 'fa:bolt'
                    label.foreground = "rgb(0,147,69)"
            
                
            self.warnings_panel.add_component(label)
            #label.text = name
            label.tooltip = tooltip
            

    def build_graphs(self):
        self.figure_container.clear()
        layout = init_vals["layout"]
        tab, sub_tab = self.selected_tab
        form = get_open_form()
        try:
            #These were added in order to let the heights be a half of the remaining height
            self._plot(layout[tab.tag][sub_tab.tag]["Top"],form.height/2)
            self._plot(layout[tab.tag][sub_tab.tag]["Bottom"],form.height/2)
            
            
        except KeyError:
            try:
                self._plot(layout[tab.tag][sub_tab.tag]["Page"],form.height)
                #self._plot(layout[tab.tag][sub_tab.tag]["Page"],form.width)
                self.figure_container.add_component(Plot())
            except KeyError:
                pass

    def _plot(self, graph_data,height):
        ## for removing the modebar, add the necessary changes here. Most configurations of the plots can be made here
        config = {'displayModeBar': False}
        plot = Plot(height=height,config=config)
        self.figure_container.add_component(plot)
        title, output, plot_type, axis_unit = graph_data
        PLOTS_REGISTRY[plot_type.lower()](
            plot, self.model_solution, output, title, axis_unit
        )

    @property
    def selected_tab(self):
        return self._selected_tab

    @selected_tab.setter
    def selected_tab(self, tab):
        for t in self.tabs.get_components():
            t.role = "active-button" if t is tab[0] else ""
        for t in self.sub_tabs.get_components():
            t.role = "active-button" if t is tab[1] else ""
        self._selected_tab = tab

    def tab_click(self, **event_args):
        """This method is called when the button is clicked"""
        current_tab, current_sub_tab = self.selected_tab
        sender = event_args["sender"]
        if sender in self.tabs.get_components():
            current_tab = sender
            current_sub_tab = self.build_sub_tabs(current_tab)
        elif sender in self.sub_tabs.get_components():
            current_sub_tab = sender
        self.selected_tab = current_tab, current_sub_tab

        self.build_graphs()
