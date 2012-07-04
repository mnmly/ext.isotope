fs = require('fs')

{print} = require 'util'
{spawn} = require 'child_process'

build = (callback) ->
  
  coffee = spawn 'coffee', ['-c', '-o', '.', '.']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()

  coffee.stdout.on 'data', (data) ->
    print data.toString()

  coffee.on 'exit', (code) ->
    fs.unlinkSync('ext.isotope.amd.coffee') if code is 0

task 'build', 'Build', ->

  isotope = fs.readFileSync('ext.isotope.coffee', 'utf-8')

  isotopeAmd = """define ['isotope'], ->
    $isotope""".replace(/\$isotope/, isotope.replace(/\n/g, '\n  '))
  
  fs.writeFileSync('ext.isotope.amd.coffee', isotopeAmd)

  build()

