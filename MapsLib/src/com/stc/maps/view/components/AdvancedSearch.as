package com.stc.maps.view.components
{
	import com.stc.maps.managers.CatalogManager;
	import com.stc.maps.model.ModelLocator;
	import com.stc.maps.view.components.event.AdvancedSearchEvent;
	import com.stc.maps.vo.FilterOptionVO;
	import com.stc.maps.vo.FilterVO;
	import com.stc.maps.vo.FilterValueVO;
	
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.containers.HBox;
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.ComboBox;
	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.controls.TextInput;
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;

	public class AdvancedSearch extends SuperPanel
	{
		private var _searchFilters : ArrayCollection;
		private var searchFiltersChange : Boolean;
		
		private var pTitleBar:UIComponent;
		private var showSearch : LinkButton = new LinkButton();
		
		private var catalogManager : CatalogManager = CatalogManager.getInstance();
		
		public var instructionLabel : String = "Configura tu busqueda y presiona BUSCAR:";
		private var textAreaInstructions : Label = new Label();
		private var searchButton : Button = new Button();
		private var content : VBox = new VBox();
		private var cancelSearchButton : Button = new Button();
		private var formItems : Array = [];
		
		private var expanded : Boolean;
		
		public function AdvancedSearch()
		{
			super();
		}

		public function set searchFilters(value : ArrayCollection) : void
		{
			if(value && value.length>0)
			{
				_searchFilters = value;
				searchFiltersChange = true;
				
				invalidateProperties();
			}
		}

		public function get searchFilters() : ArrayCollection
		{
			return _searchFilters;
		}
		
 		override protected function createChildren():void
		{
			super.createChildren();
			
			showSearch.label = "Buscar ahora";
			
			this.titleBar.addChild(showSearch);
			this.titleBar.setStyle("horizontalAlign","left");
			this.setStyle("horizontalAlign","left");
			showSearch.setStyle("color","#FFFFFF");
			textAreaInstructions.setStyle("boderStyle","none");
			//textAreaInstructions.editable = false;
			textAreaInstructions.percentWidth = 100;
			textAreaInstructions.text = instructionLabel;
			//textAreaInstructions.wordWrap = true;
			searchButton.label = "Buscar";
			cancelSearchButton.label = "Ocultar";
			
			cancelSearchButton.addEventListener(MouseEvent.CLICK, cancelSearchButton_click, false, 0, true);
			showSearch.addEventListener(MouseEvent.CLICK, addAllItems, false, 0, true);
			addChild(content);
			
			content.percentWidth = 100;
			
            showSearch.buttonMode       = true;
            showSearch.useHandCursor = true;
            showSearch.width = 100;
            showSearch.height = 22;
            showSearch.x = this.unscaledWidth - showSearch.width;
            showSearch.y = 0;	
		}
		
		private function cancelSearchButton_click(event : MouseEvent) : void
		{
			this.titleBarClickHandler(event);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if(searchFiltersChange && expanded)
			{
				searchFiltersChange = false;
				
				content.removeAllChildren();
				content.addChild(textAreaInstructions);
				
				renderSearchForm(searchFilters);
				
				var hbx : HBox = new HBox();
				hbx.percentWidth = 100;
				hbx.addChild(searchButton);
				hbx.addChild(cancelSearchButton);
				hbx.setStyle("horizontalAlign","center");
				hbx.setStyle("horizontalGap","10");
				content.addChild(hbx);
				
				this.setStyle("padding-left","10");
				this.setStyle("padding-right","10");
				this.setStyle("padding-top","10");
				this.setStyle("padding-bottom","10");
				
				this.addEventListener(ResizeEvent.RESIZE, advancedSearch_resize, false, 0, true);
				searchButton.addEventListener(MouseEvent.CLICK,searchButton_clickHandler);
			}
		}
		
		private function searchButton_clickHandler(ev : MouseEvent) : void
		{
			var filters : ArrayCollection = new ArrayCollection();
			for(var i : int=0;i<_searchFilters.length;i++)
			{
				var filter : FilterVO = _searchFilters.getItemAt(i) as FilterVO;
				var value : Object = getValuesOfRenderer(filter,formItems[i]);
				
				var filterValue : FilterValueVO = new FilterValueVO();
				filterValue.name = filter.keyName;
				if(value is ArrayCollection) filterValue.values = value as ArrayCollection;
				else if(value is String) filterValue.value = value as String;		
				else if(value is FilterOptionVO) filterValue.value = FilterOptionVO(value).id.toString();	
				filters.addItem(filterValue);
			}
			
			var event : AdvancedSearchEvent = new AdvancedSearchEvent(AdvancedSearchEvent.SEARCH);
			event.searchFilterValues = filters;
			this.dispatchEvent(event);
			
		}
		
		private function addAllItems(event : MouseEvent) : void
		{
			expanded = true;
			invalidateProperties();
		}
		
		private function advancedSearch_resize(event : ResizeEvent):void
		{
			if(this.isExpanded)
			{
				this.initPos();
			}
			//this.removeEventListener(ResizeEvent.RESIZE,advancedSearch_resize);
		}
		
		private function renderSearchForm(filters : ArrayCollection) : void
		{
			formItems = [];
			for each(var filt : FilterVO in filters)
			{
				var item : UIComponent = getTypeRenderer(filt);
				content.addChild(item);
			}
		}
		
		private function getTypeRenderer(filt : FilterVO) : UIComponent
		{
			var labelField : Label = new Label();
			labelField.text = filt.label;
			labelField.setStyle("fontWeight","bold");
			var wraper : HBox = new HBox();
			wraper.setStyle("horizontalAlign","left");
			wraper.addChild(labelField);
			wraper.percentWidth = 100;
			
			switch(filt.type)
			{
				case FilterVO.TEXT:
					var txtinpt : TextInput = new TextInput();
					txtinpt.percentWidth = 80;
					wraper.addChild(txtinpt);
					formItems.push(txtinpt);
					return wraper;
				break;
				case FilterVO.COMBO:
					var cmb : ComboBox = new ComboBox();
					cmb.percentWidth = 80;
					cmb.dataProvider = catalogManager.getCatalog(filt.keyName);
					wraper.addChild(cmb);
					formItems.push(cmb);
					return wraper;
				break;
				case FilterVO.MULTIPLE:
					var mult : MultiselectRenderer = new MultiselectRenderer();
					mult.labelOption = filt.label;
					mult.dataProvider = catalogManager.getCatalog(filt.keyName);
					mult.percentWidth = 80;
					formItems.push(mult);
					return mult;
				break;
				default:
					var txtinptx : TextInput = new TextInput();
					wraper.addChild(txtinptx);
					formItems.push(txtinptx);
					return wraper;
				break;
			}
		}
		
		private function getValuesOfRenderer(filt : FilterVO, renderer : UIComponent) : Object
		{
			switch(filt.type)
			{
				case FilterVO.TEXT:
					var txtinpt : TextInput = TextInput(renderer);
					return txtinpt.text;
				break;
				case FilterVO.COMBO:
					var cmb : ComboBox = ComboBox(renderer);
					return cmb.selectedItem;
				break;
				case FilterVO.MULTIPLE:
					var mult : MultiselectRenderer = MultiselectRenderer(renderer);
					return mult;
				break;
				default:
					var txtinptx : TextInput = TextInput(renderer);
					return txtinptx.text;
				break;
			}
		}
	}
}