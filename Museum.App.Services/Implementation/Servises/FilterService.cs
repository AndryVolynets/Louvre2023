﻿using AutoMapper;
using Museum.App.Services.Abstractions;
using Museum.App.Services.Adapters;
using Museum.App.Services.Attributes;
using Museum.App.Services.Implementation.Repositories;
using Museum.App.Services.Interfaces.Servises;
using Museum.App.ViewModels.Filter;
using Museum.App.ViewModels.FilterViewModels;
using Museum.App.ViewModels.Home;
using Museum.Models.TableModels;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Dommel.Json.JsonParsers;

namespace Museum.App.Services.Implementation.Servises
{
    [Service]
    public class FilterService : IFilterService
    {
        private readonly IMapper _mapper;
        private readonly IBasicService<Artists ,ArtistAdapter> _artistService;
        private readonly IBasicService<Categories, CategoryAdapter> _categoryService;
        private readonly IBasicService<Collections, CollectionAdapter> _collectionService;
        private readonly IFilterRepository _filterRepository;

        public FilterService(IMapper mapper, 
                             IBasicService<Artists, ArtistAdapter> artistService,
                             IBasicService<Categories, CategoryAdapter> categoryService,
                             IBasicService<Collections, CollectionAdapter> collectionService,
                             IFilterRepository filterRepository)
        {
            _mapper = mapper;
            _artistService = artistService;
            _categoryService = categoryService;
            _collectionService = collectionService;
            _filterRepository = filterRepository;
        }

        public IEnumerable<ArtistAdapter> GetArtists() => _artistService.GetAll();

        public IEnumerable<CategoryAdapter> GetCategories() => _categoryService.GetAll();

        public IEnumerable<CollectionAdapter> GetDepartmens() => _collectionService.GetAll();

        public IEnumerable<FilterSectionViewModel> GetGalleryObjectsAsFilterPage()
        {
            return _mapper.Map<IEnumerable<FilterSectionViewModel>>(_filterRepository.GetGalleryObjectsAsFilterPage());
        }

        public IEnumerable<SideBarCollection> GetSideBarCollections()
        {
            List<FilterSideBarParams> items= new List<FilterSideBarParams>
            {
                new FilterSideBarParams
                {
                    tableName = "Collections",
                    labelName = "department",
                    tablePK = "Collection_ID",
                    GalleryObjectFK = "Collection_ID"
                },
                new FilterSideBarParams
                {
                    tableName = "Artists",
                    labelName = "FullName",
                    tablePK = "Artist_ID",
                    GalleryObjectFK = "Artist_ID"
                },
                new FilterSideBarParams
                {
                    tableName = "Categories",
                    labelName = "CategoryName",
                    tablePK = "Category_ID",
                    GalleryObjectFK = "Category_ID"
                },
                new FilterSideBarParams
                {
                    tableName = "CollectionParts",
                    labelName = "PartName",
                    tablePK = "Part_ID",
                    GalleryObjectFK = "Collection_ID"
                }
            }; 

            if (items != null)
            {
                List<SideBarCollection> sideBars = new();

                foreach (var item in items)
                {
                    sideBars.Add(new SideBarCollection
                    {
                        Title = item.tableName,
                        Collection = _filterRepository.GetFilterSideBarCollection(item)
                    });
                }
                return sideBars;
            }
            return Enumerable.Empty<SideBarCollection>();
        }

    }
}
